const std = @import("std");
const syntax = @import("syntax.zig");

pub const Counts = struct {
    blank: u64 = 0,
    comment: u64 = 0,
    code: u64 = 0,
};

pub const CountOptions = struct {
    debug: bool = false,
};

pub const LineClassification = enum {
    blank,
    comment,
    code,
};

const BlockCommentState = struct {
    rule: syntax.BlockCommentRule,
    depth: usize = 1,
};

const Mode = union(enum) {
    normal,
    line_comment,
    block_comment: BlockCommentState,
    quoted: syntax.QuotedRule,
    line_string,
};

const LineState = struct {
    code: bool = false,
    comment: bool = false,

    fn markCode(self: *LineState) void {
        self.code = true;
    }

    fn markComment(self: *LineState) void {
        self.comment = true;
    }

    fn hasContent(self: LineState) bool {
        return self.code or self.comment;
    }
};

const Scanner = struct {
    spec: syntax.SyntaxSpec,
    text: []const u8,
    i: usize = 0,
    mode: Mode = .normal,
    line: LineState = .{},
    counts: Counts = .{},
    options: CountOptions = .{},
    line_number: u64 = 1,
    line_start: usize = 0,

    fn run(self: *Scanner) Counts {
        while (self.i < self.text.len) {
            self.step();
            self.i += 1;
        }

        if (self.line.hasContent()) {
            self.finishLine();
        }

        return self.counts;
    }

    fn step(self: *Scanner) void {
        switch (self.mode) {
            .normal => self.scanNormal(),
            .line_comment => self.scanLineComment(),
            .block_comment => |rule| self.scanBlockComment(rule),
            .quoted => |rule| self.scanQuoted(rule),
            .line_string => self.scanLineString(),
        }
    }

    fn scanNormal(self: *Scanner) void {
        const c = self.text[self.i];

        if (c == '\n') {
            self.finishLine();
        } else if (isHorizontalWhitespace(c)) {
            return;
        } else if (self.matchLineString()) |rule| {
            _ = rule;
            self.line.markCode();
            self.mode = .line_string;
        } else if (self.matchBlockComment()) |rule| {
            self.line.markComment();
            self.mode = .{ .block_comment = .{ .rule = rule } };
            self.i += rule.start.len - 1;
        } else if (self.matchingLineComment()) |rule| {
            self.line.markComment();
            self.mode = .line_comment;
            self.i += rule.marker.len - 1;
        } else if (self.matchQuoted()) |rule| {
            self.line.markCode();
            self.mode = .{ .quoted = rule };
            self.i += rule.start.len - 1;
        } else {
            self.line.markCode();
        }
    }

    fn scanLineComment(self: *Scanner) void {
        self.line.markComment();

        if (self.text[self.i] == '\n') {
            self.finishLine();
            self.mode = .normal;
        }
    }

    fn scanBlockComment(self: *Scanner, state: BlockCommentState) void {
        self.line.markComment();

        if (self.text[self.i] == '\n') {
            self.finishLine();
        } else if (state.rule.nested and self.startsWithAt(state.rule.start)) {
            self.mode = .{ .block_comment = .{
                .rule = state.rule,
                .depth = state.depth + 1,
            } };
            self.i += state.rule.start.len - 1;
        } else if (self.startsWithAt(state.rule.end)) {
            if (state.depth > 1) {
                self.mode = .{ .block_comment = .{
                    .rule = state.rule,
                    .depth = state.depth - 1,
                } };
            } else {
                self.mode = .normal;
            }

            self.i += state.rule.end.len - 1;
        }
    }

    fn scanQuoted(self: *Scanner, rule: syntax.QuotedRule) void {
        const c = self.text[self.i];

        self.line.markCode();

        if (c == '\n') {
            self.finishLine();

            if (!rule.multiline) {
                self.mode = .normal;
            }

            return;
        }

        if (rule.escape) |escape| {
            if (c == escape and self.i + 1 < self.text.len) {
                self.i += 1;
                return;
            }
        }

        if (self.startsWithAt(rule.end)) {
            self.mode = .normal;
            self.i += rule.end.len - 1;
            return;
        }
    }

    fn scanLineString(self: *Scanner) void {
        self.line.markCode();

        if (self.text[self.i] == '\n') {
            self.finishLine();
            self.mode = .normal;
        }
    }

    fn matchingLineComment(self: *Scanner) ?syntax.LineCommentRule {
        for (self.spec.line_comments) |rule| {
            if (self.startsWithAt(rule.marker)) {
                return rule;
            }
        }

        return null;
    }

    fn matchBlockComment(self: *Scanner) ?syntax.BlockCommentRule {
        for (self.spec.block_comments) |rule| {
            if (self.startsWithAt(rule.start)) {
                return rule;
            }
        }

        return null;
    }

    fn matchQuoted(self: *Scanner) ?syntax.QuotedRule {
        for (self.spec.quoted) |rule| {
            if (self.startsWithAt(rule.start)) {
                return rule;
            }
        }

        return null;
    }

    fn matchLineString(self: *Scanner) ?syntax.LineStringRule {
        for (self.spec.line_strings) |rule| {
            if (self.startsWithAt(rule.marker)) {
                return rule;
            }
        }

        return null;
    }

    fn startsWithAt(self: *Scanner, needle: []const u8) bool {
        return std.mem.startsWith(u8, self.text[self.i..], needle);
    }

    fn finishLine(self: *Scanner) void {
        const classification: LineClassification = if (self.line.code)
            .code
        else if (self.line.comment)
            .comment
        else
            .blank;

        switch (classification) {
            .code => self.counts.code += 1,
            .comment => self.counts.comment += 1,
            .blank => self.counts.blank += 1,
        }

        if (self.options.debug) {
            self.printLineTrace(classification);
        }

        self.line = .{};
        self.line_number += 1;
        self.line_start = self.i + 1;
    }

    fn printLineTrace(self: *Scanner, classification: LineClassification) void {
        var line_end = self.i;
        if (line_end > self.line_start and self.text[line_end - 1] == '\r') {
            line_end -= 1;
        }

        const line_text = self.text[self.line_start..line_end];
        std.debug.print("{d}: {s}: {s}\n", .{
            self.line_number,
            @tagName(classification),
            line_text,
        });
    }
};

fn isHorizontalWhitespace(c: u8) bool {
    return c == ' ' or c == '\t' or c == '\r';
}

pub fn countWithSyntax(spec: syntax.SyntaxSpec, text: []const u8) Counts {
    return countWithSyntaxOptions(spec, text, .{});
}

pub fn countWithSyntaxOptions(
    spec: syntax.SyntaxSpec,
    text: []const u8,
    options: CountOptions,
) Counts {
    var scanner = Scanner{
        .spec = spec,
        .text = text,
        .options = options,
    };

    return scanner.run();
}

fn expectCounts(spec: syntax.SyntaxSpec, text: []const u8, blank: u64, comment: u64, code: u64) !void {
    const counts = countWithSyntax(spec, text);

    try std.testing.expectEqual(blank, counts.blank);
    try std.testing.expectEqual(comment, counts.comment);
    try std.testing.expectEqual(code, counts.code);
}

test "counts line comments" {
    const spec = syntax.SyntaxSpec{
        .line_comments = &.{.{ .marker = "#" }},
    };

    const text =
        \\code
        \\
        \\# comment
        \\code # trailing comment
    ;

    try expectCounts(spec, text, 1, 1, 2);
}

test "counts block comments" {
    const spec = syntax.SyntaxSpec{
        .block_comments = &.{.{ .start = "/*", .end = "*/" }},
    };

    const text =
        \\code
        \\/*
        \\
        \\*/
        \\code
    ;

    try expectCounts(spec, text, 0, 3, 2);
}

test "matches block comments before overlapping line comments" {
    const spec = syntax.SyntaxSpec{
        .line_comments = &.{.{ .marker = "--" }},
        .block_comments = &.{.{ .start = "--[[", .end = "]]" }},
    };

    const text =
        \\--[[
        \\comment
        \\]]
        \\code
    ;

    try expectCounts(spec, text, 0, 3, 1);
}

test "ignores comment markers inside quoted strings" {
    const spec = syntax.SyntaxSpec{
        .line_comments = &.{.{ .marker = "//" }},
        .block_comments = &.{.{ .start = "/*", .end = "*/" }},
        .quoted = &.{
            .{ .start = "\"", .end = "\"", .escape = '\\' },
        },
    };

    const text =
        \\const url = "https://example.com/* not a comment */";
        \\// comment
    ;

    try expectCounts(spec, text, 0, 1, 1);
}

test "counts multiline quoted strings as code" {
    const spec = syntax.SyntaxSpec{
        .line_comments = &.{.{ .marker = "//" }},
        .quoted = &.{
            .{ .start = "`", .end = "`", .multiline = true },
        },
    };

    const text =
        \\`// not a comment
        \\still string`
        \\// comment
    ;

    try expectCounts(spec, text, 0, 1, 2);
}

test "counts line strings as code" {
    const spec = syntax.SyntaxSpec{
        .line_comments = &.{.{ .marker = "//" }},
        .line_strings = &.{.{ .marker = "\\\\" }},
    };

    const text =
        \\\\// not a comment
        \\// comment
    ;

    try expectCounts(spec, text, 0, 1, 1);
}

test "counts nested block comments" {
    const spec = syntax.SyntaxSpec{
        .block_comments = &.{.{ .start = "/*", .end = "*/", .nested = true }},
    };

    const text =
        \\/*
        \\outer
        \\/*
        \\inner
        \\*/
        \\outer again
        \\*/
        \\code
    ;

    try expectCounts(spec, text, 0, 7, 1);
}
