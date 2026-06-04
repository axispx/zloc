const std = @import("std");
const languages = @import("languages.zig");
const lexer = @import("lexer.zig");
const report = @import("report.zig");
const walker = @import("walker.zig");

pub const Language = languages.Language;
pub const Counts = lexer.Counts;
pub const CountOptions = lexer.CountOptions;

pub fn countText(language: Language, text: []const u8) Counts {
    return countTextOptions(language, text, .{});
}

pub fn countTextOptions(language: Language, text: []const u8, options: CountOptions) Counts {
    const spec = languages.syntaxFor(language);
    return lexer.countWithSyntaxOptions(spec, text, options);
}

pub fn run(io: std.Io, args: []const [:0]const u8) !void {
    if (args.len < 2) {
        std.debug.print("usage: {s} [--debug] <file>...\n", .{args[0]});
        return;
    }

    var debug = false;
    var path_index: usize = 1;

    if (std.mem.eql(u8, args[1], "--debug")) {
        if (args.len < 3) {
            std.debug.print("usage: {s} [--debug] <file>...\n", .{args[0]});
            return;
        }

        debug = true;
        path_index = 2;
    }

    var buffer: [64 * 1024]u8 = undefined;
    var summaries = report.initSummaries();

    var context = walker.Context{
        .io = io,
        .debug = debug,
        .summaries = &summaries,
        .buffer = &buffer,
    };

    for (args[path_index..]) |path| {
        try walker.countPath(&context, path);
    }

    report.printSummaryTable(&summaries);
}

test "C code" {
    const text =
        \\#include <stdio.h>
        \\
        \\/* single-line block comment */
        \\
        \\// single-line line comment
        \\
        \\/*
        \\ * multi-line block comment
        \\ * with a middle line
        \\
        \\ * and empty line
        \\ */
        \\
        \\int main(void) {
        \\    // comment inside function
        \\    printf("hello\n");
        \\
        \\    /* block comment inside function */
        \\    printf("world\n"); // trailing line comment
        \\
        \\    printf("before block\n"); /* trailing block comment */
        \\
        \\    /* leading block comment */ printf("after block\n");
        \\
        \\    /*
        \\     * multi-line block comment inside function
        \\     */
        \\    printf("done\n");
        \\
        \\    return 0;
        \\}
        \\
        \\/*
        \\block comment after code
        \\*/
    ;

    const counts = countText(.c, text);

    try std.testing.expectEqual(@as(u64, 10), counts.blank);
    try std.testing.expectEqual(@as(u64, 16), counts.comment);
    try std.testing.expectEqual(@as(u64, 9), counts.code);
}

test "Zig code" {
    const text =
        \\const std = @import("std");
        \\
        \\// line comment
        \\const url = "https://example.com";
        \\
        \\const message =
        \\    \\// not a comment
        \\    \\still string content
        \\;
    ;

    const counts = countText(.zig, text);

    try std.testing.expectEqual(@as(u64, 2), counts.blank);
    try std.testing.expectEqual(@as(u64, 1), counts.comment);
    try std.testing.expectEqual(@as(u64, 6), counts.code);
}

test "Go code" {
    const text =
        \\package main
        \\
        \\// line comment
        \\/*
        \\block comment
        \\
        \\*/
        \\
        \\func main() {
        \\    message := `// not a comment
        \\still raw string`
        \\    println(message) // trailing comment
        \\}
    ;

    const counts = countText(.go, text);

    try std.testing.expectEqual(@as(u64, 2), counts.blank);
    try std.testing.expectEqual(@as(u64, 5), counts.comment);
    try std.testing.expectEqual(@as(u64, 6), counts.code);
}
