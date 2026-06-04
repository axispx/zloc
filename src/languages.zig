const std = @import("std");
const syntax = @import("syntax.zig");

// Supported languages
pub const Language = enum {
    c,
    csharp,
    cpp,
    css,
    go,
    html,
    java,
    javascript,
    json,
    php,
    python,
    rust,
    sass,
    shell,
    sql,
    toml,
    typescript,
    xml,
    yaml,
    zig,
};

const LanguageSpec = struct {
    language: Language,
    extensions: []const []const u8,
    syntax: syntax.SyntaxSpec,
};

pub const supported_languages = [_]Language{
    .c,
    .csharp,
    .cpp,
    .css,
    .go,
    .html,
    .java,
    .javascript,
    .json,
    .php,
    .python,
    .rust,
    .sass,
    .shell,
    .sql,
    .toml,
    .typescript,
    .xml,
    .yaml,
    .zig,
};

pub const c_syntax = syntax.SyntaxSpec{
    .line_comments = &.{.{ .marker = "//" }},
    .block_comments = &.{.{ .start = "/*", .end = "*/" }},
    .quoted = &.{
        .{ .start = "\"", .end = "\"", .escape = '\\' },
        .{ .start = "'", .end = "'", .escape = '\\' },
    },
};

pub const csharp_syntax = c_syntax;
pub const cpp_syntax = c_syntax;

pub const css_syntax = syntax.SyntaxSpec{
    .block_comments = &.{.{ .start = "/*", .end = "*/" }},
    .quoted = &.{
        .{ .start = "\"", .end = "\"", .escape = '\\' },
        .{ .start = "'", .end = "'", .escape = '\\' },
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

pub const html_syntax = syntax.SyntaxSpec{
    .block_comments = &.{.{ .start = "<!--", .end = "-->" }},
    .quoted = &.{
        .{ .start = "\"", .end = "\"", .escape = '\\' },
        .{ .start = "'", .end = "'", .escape = '\\' },
    },
};

pub const java_syntax = c_syntax;

pub const javascript_syntax = syntax.SyntaxSpec{
    .line_comments = &.{.{ .marker = "//" }},
    .block_comments = &.{.{ .start = "/*", .end = "*/" }},
    .quoted = &.{
        .{ .start = "\"", .end = "\"", .escape = '\\' },
        .{ .start = "'", .end = "'", .escape = '\\' },
        .{ .start = "`", .end = "`", .escape = '\\', .multiline = true },
    },
};

pub const json_syntax = syntax.SyntaxSpec{
    .quoted = &.{
        .{ .start = "\"", .end = "\"", .escape = '\\' },
    },
};

pub const php_syntax = syntax.SyntaxSpec{
    .line_comments = &.{ .{ .marker = "//" }, .{ .marker = "#" } },
    .block_comments = &.{.{ .start = "/*", .end = "*/" }},
    .quoted = &.{
        .{ .start = "\"", .end = "\"", .escape = '\\' },
        .{ .start = "'", .end = "'", .escape = '\\' },
        .{ .start = "`", .end = "`", .escape = '\\' },
    },
};

pub const python_syntax = syntax.SyntaxSpec{
    .line_comments = &.{.{ .marker = "#" }},
    .quoted = &.{
        .{ .start = "\"\"\"", .end = "\"\"\"", .escape = '\\', .multiline = true },
        .{ .start = "'''", .end = "'''", .escape = '\\', .multiline = true },
        .{ .start = "\"", .end = "\"", .escape = '\\' },
        .{ .start = "'", .end = "'", .escape = '\\' },
    },
};

pub const rust_syntax = syntax.SyntaxSpec{
    .line_comments = &.{.{ .marker = "//" }},
    .block_comments = &.{.{ .start = "/*", .end = "*/", .nested = true }},
    .quoted = &.{
        .{ .start = "\"", .end = "\"", .escape = '\\' },
        .{ .start = "'", .end = "'", .escape = '\\' },
    },
};

pub const sass_syntax = syntax.SyntaxSpec{
    .line_comments = &.{.{ .marker = "//" }},
    .block_comments = &.{.{ .start = "/*", .end = "*/" }},
    .quoted = &.{
        .{ .start = "\"", .end = "\"", .escape = '\\' },
        .{ .start = "'", .end = "'", .escape = '\\' },
    },
};

pub const shell_syntax = syntax.SyntaxSpec{
    .line_comments = &.{.{ .marker = "#" }},
    .quoted = &.{
        .{ .start = "\"", .end = "\"", .escape = '\\' },
        .{ .start = "'", .end = "'" },
        .{ .start = "`", .end = "`", .escape = '\\' },
    },
};

pub const sql_syntax = syntax.SyntaxSpec{
    .line_comments = &.{.{ .marker = "--" }},
    .block_comments = &.{.{ .start = "/*", .end = "*/" }},
    .quoted = &.{
        .{ .start = "'", .end = "'" },
        .{ .start = "\"", .end = "\"" },
    },
};

pub const toml_syntax = syntax.SyntaxSpec{
    .line_comments = &.{.{ .marker = "#" }},
    .quoted = &.{
        .{ .start = "\"\"\"", .end = "\"\"\"", .escape = '\\', .multiline = true },
        .{ .start = "'''", .end = "'''", .multiline = true },
        .{ .start = "\"", .end = "\"", .escape = '\\' },
        .{ .start = "'", .end = "'" },
    },
};

pub const typescript_syntax = javascript_syntax;
pub const xml_syntax = html_syntax;

pub const yaml_syntax = syntax.SyntaxSpec{
    .line_comments = &.{.{ .marker = "#" }},
    .quoted = &.{
        .{ .start = "\"", .end = "\"", .escape = '\\' },
        .{ .start = "'", .end = "'" },
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
        .language = .csharp,
        .extensions = &.{".cs"},
        .syntax = csharp_syntax,
    },
    .{
        .language = .cpp,
        .extensions = &.{ ".cc", ".cpp", ".cxx", ".hh", ".hpp", ".hxx" },
        .syntax = cpp_syntax,
    },
    .{
        .language = .css,
        .extensions = &.{".css"},
        .syntax = css_syntax,
    },
    .{
        .language = .go,
        .extensions = &.{".go"},
        .syntax = go_syntax,
    },
    .{
        .language = .html,
        .extensions = &.{ ".htm", ".html" },
        .syntax = html_syntax,
    },
    .{
        .language = .java,
        .extensions = &.{".java"},
        .syntax = java_syntax,
    },
    .{
        .language = .javascript,
        .extensions = &.{ ".cjs", ".js", ".jsx", ".mjs" },
        .syntax = javascript_syntax,
    },
    .{
        .language = .json,
        .extensions = &.{".json"},
        .syntax = json_syntax,
    },
    .{
        .language = .php,
        .extensions = &.{ ".php", ".phtml" },
        .syntax = php_syntax,
    },
    .{
        .language = .python,
        .extensions = &.{ ".py", ".pyw" },
        .syntax = python_syntax,
    },
    .{
        .language = .rust,
        .extensions = &.{".rs"},
        .syntax = rust_syntax,
    },
    .{
        .language = .sass,
        .extensions = &.{ ".sass", ".scss" },
        .syntax = sass_syntax,
    },
    .{
        .language = .shell,
        .extensions = &.{ ".bash", ".fish", ".sh", ".zsh" },
        .syntax = shell_syntax,
    },
    .{
        .language = .sql,
        .extensions = &.{".sql"},
        .syntax = sql_syntax,
    },
    .{
        .language = .toml,
        .extensions = &.{".toml"},
        .syntax = toml_syntax,
    },
    .{
        .language = .typescript,
        .extensions = &.{ ".cts", ".mts", ".ts", ".tsx" },
        .syntax = typescript_syntax,
    },
    .{
        .language = .xml,
        .extensions = &.{".xml"},
        .syntax = xml_syntax,
    },
    .{
        .language = .yaml,
        .extensions = &.{ ".yaml", ".yml" },
        .syntax = yaml_syntax,
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
        .csharp => "C#",
        .cpp => "C++",
        .css => "CSS",
        .go => "Go",
        .html => "HTML",
        .java => "Java",
        .javascript => "JavaScript",
        .json => "JSON",
        .php => "PHP",
        .python => "Python",
        .rust => "Rust",
        .sass => "Sass",
        .shell => "Shell",
        .sql => "SQL",
        .toml => "TOML",
        .typescript => "TypeScript",
        .xml => "XML",
        .yaml => "YAML",
        .zig => "Zig",
    };
}

test "detect language from filename" {
    try std.testing.expectEqual(Language.c, detect("main.c").?);
    try std.testing.expectEqual(Language.csharp, detect("src/app.cs").?);
    try std.testing.expectEqual(Language.cpp, detect("src/main.cpp").?);
    try std.testing.expectEqual(Language.cpp, detect("include/main.hpp").?);
    try std.testing.expectEqual(Language.css, detect("src/app.css").?);
    try std.testing.expectEqual(Language.go, detect("main.go").?);
    try std.testing.expectEqual(Language.html, detect("public/index.html").?);
    try std.testing.expectEqual(Language.java, detect("src/Main.java").?);
    try std.testing.expectEqual(Language.javascript, detect("src/app.js").?);
    try std.testing.expectEqual(Language.javascript, detect("src/app.jsx").?);
    try std.testing.expectEqual(Language.javascript, detect("src/app.mjs").?);
    try std.testing.expectEqual(Language.javascript, detect("src/app.cjs").?);
    try std.testing.expectEqual(Language.json, detect("package.json").?);
    try std.testing.expectEqual(Language.php, detect("src/index.php").?);
    try std.testing.expectEqual(Language.python, detect("src/main.py").?);
    try std.testing.expectEqual(Language.rust, detect("src/main.rs").?);
    try std.testing.expectEqual(Language.sass, detect("src/app.scss").?);
    try std.testing.expectEqual(Language.shell, detect("scripts/build.sh").?);
    try std.testing.expectEqual(Language.sql, detect("schema.sql").?);
    try std.testing.expectEqual(Language.toml, detect("Cargo.toml").?);
    try std.testing.expectEqual(Language.typescript, detect("src/app.ts").?);
    try std.testing.expectEqual(Language.typescript, detect("src/app.tsx").?);
    try std.testing.expectEqual(Language.xml, detect("feed.xml").?);
    try std.testing.expectEqual(Language.yaml, detect("config.yaml").?);
    try std.testing.expectEqual(Language.zig, detect("src/root.zig").?);

    try std.testing.expect(detect("README.txt") == null);
}

fn expectCounts(language: Language, text: []const u8, blank: u64, comment: u64, code: u64) !void {
    const test_lexer = @import("lexer.zig");
    const counts = test_lexer.countWithSyntax(syntaxFor(language), text);

    try std.testing.expectEqual(blank, counts.blank);
    try std.testing.expectEqual(comment, counts.comment);
    try std.testing.expectEqual(code, counts.code);
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

    try expectCounts(.c, text, 10, 16, 9);
}

test "C# code" {
    const text =
        \\using System;
        \\
        \\// line comment
        \\/*
        \\block comment
        \\
        \\*/
        \\
        \\class Program {
        \\    static void Main() {
        \\        Console.WriteLine("https://example.com"); // trailing comment
        \\    }
        \\}
    ;

    try expectCounts(.csharp, text, 2, 5, 6);
}

test "C++ code" {
    const text =
        \\#include <iostream>
        \\
        \\// line comment
        \\/*
        \\block comment
        \\
        \\*/
        \\
        \\int main() {
        \\    std::cout << "https://example.com";
        \\}
    ;

    try expectCounts(.cpp, text, 2, 5, 4);
}

test "CSS code" {
    const text =
        \\body {
        \\
        \\/* block comment
        \\middle
        \\
        \\*/
        \\  color: red;
        \\}
    ;

    try expectCounts(.css, text, 1, 4, 3);
}

test "Go code" {
    const text =
        \\package main
        \\
        \\// line comment
        \\/// doc comment
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

    try expectCounts(.go, text, 2, 6, 6);
}

test "HTML code" {
    const text =
        \\<!doctype html>
        \\
        \\<!-- comment
        \\middle
        \\
        \\-->
        \\<div class="hero">Text</div>
    ;

    try expectCounts(.html, text, 1, 4, 2);
}

test "Java code" {
    const text =
        \\class Main {
        \\    public static void main(String[] args) {
        \\        String url = "https://example.com";
        \\
        \\        // line comment
        \\        /*
        \\        block comment
        \\
        \\        */
        \\        System.out.println(url); // trailing comment
        \\    }
        \\}
    ;

    try expectCounts(.java, text, 1, 5, 6);
}

test "JavaScript code" {
    const text =
        \\const url = "https://example.com";
        \\
        \\// line comment
        \\/*
        \\block comment
        \\
        \\*/
        \\
        \\const message = `// not a comment
        \\still template content`;
        \\console.log(message); // trailing comment
    ;

    try expectCounts(.javascript, text, 2, 5, 4);
}

test "JSON code" {
    const text =
        \\{
        \\  "name": "zloc",
        \\
        \\  "enabled": true
        \\}
    ;

    try expectCounts(.json, text, 1, 0, 4);
}

test "PHP code" {
    const text =
        \\<?php
        \\$uri = "https://example.com";
        \\
        \\# hash comment
        \\// line comment
        \\/*
        \\block comment
        \\
        \\*/
        \\echo $uri; // trailing comment
    ;

    try expectCounts(.php, text, 1, 6, 3);
}

test "Python code" {
    const text =
        \\import sys
        \\
        \\# line comment
        \\url = "https://example.com"
        \\text = """// not a comment
        \\still string content"""
        \\print(url)  # trailing comment
    ;

    try expectCounts(.python, text, 1, 1, 5);
}

test "Rust code" {
    const text =
        \\fn main() {
        \\    let url = "https://example.com";
        \\    // line comment
        \\    /*
        \\    outer
        \\    /*
        \\    inner
        \\    */
        \\    outer again
        \\    */
        \\    println!("{}", url); // trailing comment
        \\}
    ;

    try expectCounts(.rust, text, 0, 8, 4);
}

test "Sass code" {
    const text =
        \\$color: red;
        \\
        \\// silent comment
        \\/* loud comment
        \\middle
        \\*/
        \\.button {
        \\  color: $color; // trailing comment
        \\}
    ;

    try expectCounts(.sass, text, 1, 4, 4);
}

test "Shell code" {
    const text =
        \\echo "https://example.com"
        \\
        \\# line comment
        \\name="zloc" # trailing comment
        \\echo "$name"
    ;

    try expectCounts(.shell, text, 1, 1, 3);
}

test "SQL code" {
    const text =
        \\select 'https://example.com';
        \\
        \\-- line comment
        \\/*
        \\block comment
        \\
        \\*/
        \\select 1; -- trailing comment
    ;

    try expectCounts(.sql, text, 1, 5, 2);
}

test "TOML code" {
    const text =
        \\name = "zloc"
        \\
        \\# line comment
        \\enabled = true # trailing comment
        \\text = '''# not a comment
        \\still string content'''
    ;

    try expectCounts(.toml, text, 1, 1, 4);
}

test "TypeScript code" {
    const text =
        \\const url = "https://example.com";
        \\
        \\// line comment
        \\/*
        \\block comment
        \\
        \\*/
        \\
        \\const message = `// not a comment
        \\still template content`;
        \\console.log(message); // trailing comment
    ;

    try expectCounts(.typescript, text, 2, 5, 4);
}

test "XML code" {
    const text =
        \\<root>
        \\
        \\<!-- comment
        \\middle
        \\
        \\-->
        \\<child name="zloc"/>
        \\</root>
    ;

    try expectCounts(.xml, text, 1, 4, 3);
}

test "YAML code" {
    const text =
        \\name: zloc
        \\
        \\# line comment
        \\url: "https://example.com" # trailing comment
        \\enabled: true
    ;

    try expectCounts(.yaml, text, 1, 1, 3);
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

    try expectCounts(.zig, text, 2, 1, 6);
}
