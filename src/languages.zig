const std = @import("std");
const syntax = @import("syntax.zig");

pub const Language = enum {
    c,
    go,
    zig,
};

const LanguageSpec = struct {
    language: Language,
    extensions: []const []const u8,
    syntax: syntax.SyntaxSpec,
};

pub const supported_languages = [_]Language{
    .c,
    .go,
    .zig,
};

pub const c_syntax = syntax.SyntaxSpec{
    .line_comments = &.{.{ .marker = "//" }},
    .block_comments = &.{.{ .start = "/*", .end = "*/" }},
    .quoted = &.{
        .{ .start = "\"", .end = "\"", .escape = '\\' },
        .{ .start = "'", .end = "\'", .escape = '\\' },
    },
};

pub const go_syntax = syntax.SyntaxSpec{
    .line_comments = &.{.{ .marker = "//" }},
    .block_comments = &.{.{ .start = "/*", .end = "*/" }},
    .quoted = &.{
        .{ .start = "\"", .end = "\"", .escape = '\\' },
        .{ .start = "'", .end = "'", .escape = '\\' },
        .{ .start = "`", .end = "`", .multiline = true },
    },
};

pub const zig_syntax = syntax.SyntaxSpec{
    .line_comments = &.{.{ .marker = "//" }},
    .quoted = &.{
        .{ .start = "\"", .end = "\"", .escape = '\\' },
        .{ .start = "'", .end = "'", .escape = '\\' },
    },
    .line_strings = &.{
        .{ .marker = "\\\\" },
    },
};

pub const specs = [_]LanguageSpec{
    .{
        .language = .c,
        .extensions = &.{ ".c", ".h" },
        .syntax = c_syntax,
    },
    .{
        .language = .go,
        .extensions = &.{".go"},
        .syntax = go_syntax,
    },
    .{
        .language = .zig,
        .extensions = &.{".zig"},
        .syntax = zig_syntax,
    },
};

pub fn detect(path: []const u8) ?Language {
    for (specs) |spec| {
        if (hasAnyExtension(path, spec.extensions)) {
            return spec.language;
        }
    }

    return null;
}

pub fn hasAnyExtension(path: []const u8, extensions: []const []const u8) bool {
    for (extensions) |extension| {
        if (std.mem.endsWith(u8, path, extension)) {
            return true;
        }
    }

    return false;
}

pub fn syntaxFor(language: Language) syntax.SyntaxSpec {
    for (specs) |spec| {
        if (spec.language == language) {
            return spec.syntax;
        }
    }

    return .{};
}

pub fn name(language: Language) []const u8 {
    return switch (language) {
        .c => "C",
        .go => "Go",
        .zig => "Zig",
    };
}

test "detect language from filename" {
    try std.testing.expectEqual(Language.c, detect("main.c").?);
    try std.testing.expectEqual(Language.go, detect("main.go").?);
    try std.testing.expectEqual(Language.zig, detect("src/root.zig").?);

    try std.testing.expect(detect("README.txt") == null);
}
