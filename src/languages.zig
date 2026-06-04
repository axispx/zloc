const std = @import("std");
const syntax = @import("syntax.zig");

// Supported languages
pub const Language = enum {
    assembly,
    awk,
    c,
    c_cpp_header,
    clojure,
    csharp,
    cpp,
    csv,
    css,
    dart,
    dockerfile,
    go,
    hcl,
    html,
    java,
    javascript,
    jinja,
    json,
    kotlin,
    lex,
    lua,
    makefile,
    markdown,
    objective_c,
    perl,
    php,
    python,
    r,
    ruby,
    rust,
    sass,
    sed,
    shell,
    sql,
    svg,
    swift,
    tex,
    text,
    toml,
    typescript,
    vim_script,
    xml,
    yacc,
    yaml,
    zig,
};

const LanguageSpec = struct {
    language: Language,
    extensions: []const []const u8,
    filenames: []const []const u8 = &.{},
    syntax: syntax.SyntaxSpec,
};

pub const supported_languages = [_]Language{
    .assembly,
    .awk,
    .c,
    .c_cpp_header,
    .clojure,
    .csharp,
    .cpp,
    .csv,
    .css,
    .dart,
    .dockerfile,
    .go,
    .hcl,
    .html,
    .java,
    .javascript,
    .jinja,
    .json,
    .kotlin,
    .lex,
    .lua,
    .makefile,
    .markdown,
    .objective_c,
    .perl,
    .php,
    .python,
    .r,
    .ruby,
    .rust,
    .sass,
    .sed,
    .shell,
    .sql,
    .svg,
    .swift,
    .tex,
    .text,
    .toml,
    .typescript,
    .vim_script,
    .xml,
    .yacc,
    .yaml,
    .zig,
};

pub const assembly_syntax = syntax.SyntaxSpec{
    .line_comments = &.{
        .{ .marker = ";" },
        .{ .marker = "#" },
        .{ .marker = "@" },
        .{ .marker = "//" },
    },
    .quoted = &.{
        .{ .start = "\"", .end = "\"", .escape = '\\' },
        .{ .start = "'", .end = "'", .escape = '\\' },
    },
};

pub const awk_syntax = syntax.SyntaxSpec{
    .line_comments = &.{.{ .marker = "#" }},
    .quoted = &.{
        .{ .start = "\"", .end = "\"", .escape = '\\' },
    },
};

pub const c_syntax = syntax.SyntaxSpec{
    .line_comments = &.{.{ .marker = "//" }},
    .block_comments = &.{.{ .start = "/*", .end = "*/" }},
    .quoted = &.{
        .{ .start = "\"", .end = "\"", .escape = '\\' },
        .{ .start = "'", .end = "'", .escape = '\\' },
    },
};

pub const c_cpp_header_syntax = c_syntax;

pub const clojure_syntax = syntax.SyntaxSpec{
    .line_comments = &.{.{ .marker = ";" }},
    .quoted = &.{
        .{ .start = "\"", .end = "\"", .escape = '\\' },
    },
};

pub const csharp_syntax = c_syntax;
pub const cpp_syntax = c_syntax;

pub const csv_syntax = syntax.SyntaxSpec{
    .quoted = &.{
        .{ .start = "\"", .end = "\"", .escape = '"' },
    },
};

pub const css_syntax = syntax.SyntaxSpec{
    .block_comments = &.{.{ .start = "/*", .end = "*/" }},
    .quoted = &.{
        .{ .start = "\"", .end = "\"", .escape = '\\' },
        .{ .start = "'", .end = "'", .escape = '\\' },
    },
};

pub const dart_syntax = syntax.SyntaxSpec{
    .line_comments = &.{.{ .marker = "//" }},
    .block_comments = &.{.{ .start = "/*", .end = "*/" }},
    .quoted = &.{
        .{ .start = "\"\"\"", .end = "\"\"\"", .escape = '\\', .multiline = true },
        .{ .start = "'''", .end = "'''", .escape = '\\', .multiline = true },
        .{ .start = "\"", .end = "\"", .escape = '\\' },
        .{ .start = "'", .end = "'", .escape = '\\' },
    },
};

pub const dockerfile_syntax = syntax.SyntaxSpec{
    .line_comments = &.{.{ .marker = "#" }},
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

pub const hcl_syntax = syntax.SyntaxSpec{
    .line_comments = &.{ .{ .marker = "#" }, .{ .marker = "//" } },
    .block_comments = &.{.{ .start = "/*", .end = "*/" }},
    .quoted = &.{
        .{ .start = "\"", .end = "\"", .escape = '\\' },
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

pub const jinja_syntax = syntax.SyntaxSpec{
    .block_comments = &.{.{ .start = "{#", .end = "#}" }},
    .quoted = &.{
        .{ .start = "\"", .end = "\"", .escape = '\\' },
        .{ .start = "'", .end = "'", .escape = '\\' },
    },
};

pub const json_syntax = syntax.SyntaxSpec{
    .quoted = &.{
        .{ .start = "\"", .end = "\"", .escape = '\\' },
    },
};

pub const kotlin_syntax = syntax.SyntaxSpec{
    .line_comments = &.{.{ .marker = "//" }},
    .block_comments = &.{.{ .start = "/*", .end = "*/" }},
    .quoted = &.{
        .{ .start = "\"\"\"", .end = "\"\"\"", .multiline = true },
        .{ .start = "\"", .end = "\"", .escape = '\\' },
        .{ .start = "'", .end = "'", .escape = '\\' },
    },
};

pub const lex_syntax = c_syntax;

pub const lua_syntax = syntax.SyntaxSpec{
    .line_comments = &.{.{ .marker = "--" }},
    .block_comments = &.{.{ .start = "--[[", .end = "]]" }},
    .quoted = &.{
        .{ .start = "\"", .end = "\"", .escape = '\\' },
        .{ .start = "'", .end = "'", .escape = '\\' },
        .{ .start = "[[", .end = "]]", .multiline = true },
    },
};

pub const makefile_syntax = syntax.SyntaxSpec{
    .line_comments = &.{.{ .marker = "#" }},
    .quoted = &.{
        .{ .start = "\"", .end = "\"", .escape = '\\' },
        .{ .start = "'", .end = "'" },
    },
};

pub const markdown_syntax = html_syntax;

pub const objective_c_syntax = c_syntax;

pub const perl_syntax = syntax.SyntaxSpec{
    .line_comments = &.{.{ .marker = "#" }},
    .block_comments = &.{.{ .start = "=pod", .end = "=cut" }},
    .quoted = &.{
        .{ .start = "\"", .end = "\"", .escape = '\\' },
        .{ .start = "'", .end = "'" },
        .{ .start = "`", .end = "`", .escape = '\\' },
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

pub const r_syntax = syntax.SyntaxSpec{
    .line_comments = &.{.{ .marker = "#" }},
    .quoted = &.{
        .{ .start = "\"", .end = "\"", .escape = '\\' },
        .{ .start = "'", .end = "'", .escape = '\\' },
    },
};

pub const ruby_syntax = syntax.SyntaxSpec{
    .line_comments = &.{.{ .marker = "#" }},
    .block_comments = &.{.{ .start = "=begin", .end = "=end" }},
    .quoted = &.{
        .{ .start = "\"", .end = "\"", .escape = '\\' },
        .{ .start = "'", .end = "'" },
        .{ .start = "`", .end = "`", .escape = '\\' },
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

pub const sed_syntax = syntax.SyntaxSpec{
    .line_comments = &.{.{ .marker = "#" }},
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

pub const svg_syntax = html_syntax;

pub const swift_syntax = syntax.SyntaxSpec{
    .line_comments = &.{.{ .marker = "//" }},
    .block_comments = &.{.{ .start = "/*", .end = "*/", .nested = true }},
    .quoted = &.{
        .{ .start = "\"\"\"", .end = "\"\"\"", .escape = '\\', .multiline = true },
        .{ .start = "\"", .end = "\"", .escape = '\\' },
    },
};

pub const tex_syntax = syntax.SyntaxSpec{
    .line_comments = &.{.{ .marker = "%" }},
};

pub const text_syntax = syntax.SyntaxSpec{};

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

pub const vim_script_syntax = syntax.SyntaxSpec{
    .line_comments = &.{.{ .marker = "\"" }},
    .quoted = &.{
        .{ .start = "'", .end = "'" },
    },
};

pub const xml_syntax = html_syntax;

pub const yacc_syntax = c_syntax;

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
        .language = .assembly,
        .extensions = &.{ ".S", ".asm", ".s" },
        .syntax = assembly_syntax,
    },
    .{
        .language = .awk,
        .extensions = &.{".awk"},
        .syntax = awk_syntax,
    },
    .{
        .language = .c,
        .extensions = &.{".c"},
        .syntax = c_syntax,
    },
    .{
        .language = .c_cpp_header,
        .extensions = &.{ ".h", ".hh", ".hpp", ".hxx" },
        .syntax = c_cpp_header_syntax,
    },
    .{
        .language = .clojure,
        .extensions = &.{ ".clj", ".cljc", ".cljs", ".edn" },
        .syntax = clojure_syntax,
    },
    .{
        .language = .csharp,
        .extensions = &.{".cs"},
        .syntax = csharp_syntax,
    },
    .{
        .language = .cpp,
        .extensions = &.{ ".cc", ".cpp", ".cxx" },
        .syntax = cpp_syntax,
    },
    .{
        .language = .csv,
        .extensions = &.{".csv"},
        .syntax = csv_syntax,
    },
    .{
        .language = .css,
        .extensions = &.{".css"},
        .syntax = css_syntax,
    },
    .{
        .language = .dart,
        .extensions = &.{".dart"},
        .syntax = dart_syntax,
    },
    .{
        .language = .dockerfile,
        .extensions = &.{".dockerfile"},
        .filenames = &.{ "Dockerfile", "dockerfile" },
        .syntax = dockerfile_syntax,
    },
    .{
        .language = .go,
        .extensions = &.{".go"},
        .syntax = go_syntax,
    },
    .{
        .language = .hcl,
        .extensions = &.{ ".hcl", ".tf", ".tfvars" },
        .syntax = hcl_syntax,
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
        .language = .jinja,
        .extensions = &.{ ".j2", ".jinja", ".jinja2" },
        .syntax = jinja_syntax,
    },
    .{
        .language = .json,
        .extensions = &.{".json"},
        .syntax = json_syntax,
    },
    .{
        .language = .kotlin,
        .extensions = &.{ ".kt", ".kts" },
        .syntax = kotlin_syntax,
    },
    .{
        .language = .lex,
        .extensions = &.{ ".l", ".ll" },
        .syntax = lex_syntax,
    },
    .{
        .language = .lua,
        .extensions = &.{".lua"},
        .syntax = lua_syntax,
    },
    .{
        .language = .makefile,
        .extensions = &.{".mk"},
        .filenames = &.{ "GNUmakefile", "Makefile", "makefile" },
        .syntax = makefile_syntax,
    },
    .{
        .language = .markdown,
        .extensions = &.{ ".markdown", ".md", ".mdown", ".mkd" },
        .syntax = markdown_syntax,
    },
    .{
        .language = .objective_c,
        .extensions = &.{ ".m", ".mm" },
        .syntax = objective_c_syntax,
    },
    .{
        .language = .perl,
        .extensions = &.{ ".perl", ".pl", ".pm", ".pod", ".psgi", ".t" },
        .syntax = perl_syntax,
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
        .language = .r,
        .extensions = &.{ ".R", ".r" },
        .syntax = r_syntax,
    },
    .{
        .language = .ruby,
        .extensions = &.{ ".rake", ".rb" },
        .filenames = &.{ "Gemfile", "Rakefile" },
        .syntax = ruby_syntax,
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
        .language = .sed,
        .extensions = &.{".sed"},
        .syntax = sed_syntax,
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
        .language = .svg,
        .extensions = &.{".svg"},
        .syntax = svg_syntax,
    },
    .{
        .language = .swift,
        .extensions = &.{".swift"},
        .syntax = swift_syntax,
    },
    .{
        .language = .tex,
        .extensions = &.{ ".cls", ".sty", ".tex" },
        .syntax = tex_syntax,
    },
    .{
        .language = .text,
        .extensions = &.{ ".text", ".txt" },
        .syntax = text_syntax,
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
        .language = .vim_script,
        .extensions = &.{ ".vim", ".vimrc" },
        .filenames = &.{ ".gvimrc", ".vimrc", "_gvimrc", "_vimrc" },
        .syntax = vim_script_syntax,
    },
    .{
        .language = .xml,
        .extensions = &.{".xml"},
        .syntax = xml_syntax,
    },
    .{
        .language = .yacc,
        .extensions = &.{ ".y", ".yy" },
        .syntax = yacc_syntax,
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

const filename_languages = std.StaticStringMap(Language).initComptime(.{
    .{ ".gvimrc", .vim_script },
    .{ ".vimrc", .vim_script },
    .{ "_gvimrc", .vim_script },
    .{ "_vimrc", .vim_script },
    .{ "Dockerfile", .dockerfile },
    .{ "dockerfile", .dockerfile },
    .{ "Gemfile", .ruby },
    .{ "GNUmakefile", .makefile },
    .{ "Makefile", .makefile },
    .{ "makefile", .makefile },
    .{ "Rakefile", .ruby },
});

const extension_languages = std.StaticStringMap(Language).initComptime(.{
    .{ "asm", .assembly },
    .{ "awk", .awk },
    .{ "bash", .shell },
    .{ "c", .c },
    .{ "cc", .cpp },
    .{ "cjs", .javascript },
    .{ "clj", .clojure },
    .{ "cljc", .clojure },
    .{ "cljs", .clojure },
    .{ "cls", .tex },
    .{ "cpp", .cpp },
    .{ "cs", .csharp },
    .{ "css", .css },
    .{ "csv", .csv },
    .{ "cts", .typescript },
    .{ "cxx", .cpp },
    .{ "dart", .dart },
    .{ "dockerfile", .dockerfile },
    .{ "edn", .clojure },
    .{ "fish", .shell },
    .{ "h", .c_cpp_header },
    .{ "hcl", .hcl },
    .{ "hh", .c_cpp_header },
    .{ "hpp", .c_cpp_header },
    .{ "htm", .html },
    .{ "html", .html },
    .{ "hxx", .c_cpp_header },
    .{ "j2", .jinja },
    .{ "java", .java },
    .{ "jinja", .jinja },
    .{ "jinja2", .jinja },
    .{ "js", .javascript },
    .{ "json", .json },
    .{ "jsx", .javascript },
    .{ "kt", .kotlin },
    .{ "kts", .kotlin },
    .{ "l", .lex },
    .{ "ll", .lex },
    .{ "lua", .lua },
    .{ "m", .objective_c },
    .{ "markdown", .markdown },
    .{ "md", .markdown },
    .{ "mdown", .markdown },
    .{ "mjs", .javascript },
    .{ "mk", .makefile },
    .{ "mkd", .markdown },
    .{ "mm", .objective_c },
    .{ "mts", .typescript },
    .{ "perl", .perl },
    .{ "php", .php },
    .{ "pl", .perl },
    .{ "pm", .perl },
    .{ "pod", .perl },
    .{ "psgi", .perl },
    .{ "py", .python },
    .{ "pyw", .python },
    .{ "R", .r },
    .{ "r", .r },
    .{ "rake", .ruby },
    .{ "rb", .ruby },
    .{ "rs", .rust },
    .{ "S", .assembly },
    .{ "s", .assembly },
    .{ "sass", .sass },
    .{ "scss", .sass },
    .{ "sed", .sed },
    .{ "sh", .shell },
    .{ "sql", .sql },
    .{ "sty", .tex },
    .{ "svg", .svg },
    .{ "swift", .swift },
    .{ "t", .perl },
    .{ "tex", .tex },
    .{ "text", .text },
    .{ "tf", .hcl },
    .{ "tfvars", .hcl },
    .{ "toml", .toml },
    .{ "ts", .typescript },
    .{ "tsx", .typescript },
    .{ "txt", .text },
    .{ "vim", .vim_script },
    .{ "vimrc", .vim_script },
    .{ "xml", .xml },
    .{ "y", .yacc },
    .{ "yaml", .yaml },
    .{ "yml", .yaml },
    .{ "yy", .yacc },
    .{ "zig", .zig },
    .{ "zsh", .shell },
});

pub fn detect(path: []const u8) ?Language {
    const basename = std.fs.path.basename(path);

    if (filename_languages.get(basename)) |language| {
        return language;
    }

    return extension_languages.get(std.fs.path.extension(basename));
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
        .assembly => "Assembly",
        .awk => "Awk",
        .c => "C",
        .c_cpp_header => "C/C++ Header",
        .clojure => "Clojure",
        .csharp => "C#",
        .cpp => "C++",
        .csv => "CSV",
        .css => "CSS",
        .dart => "Dart",
        .dockerfile => "Dockerfile",
        .go => "Go",
        .hcl => "HCL",
        .html => "HTML",
        .java => "Java",
        .javascript => "JavaScript",
        .jinja => "Jinja",
        .json => "JSON",
        .kotlin => "Kotlin",
        .lex => "Lex",
        .lua => "Lua",
        .makefile => "Makefile",
        .markdown => "Markdown",
        .objective_c => "Objective-C",
        .perl => "Perl",
        .php => "PHP",
        .python => "Python",
        .r => "R",
        .ruby => "Ruby",
        .rust => "Rust",
        .sass => "Sass",
        .sed => "sed",
        .shell => "Shell",
        .sql => "SQL",
        .svg => "SVG",
        .swift => "Swift",
        .tex => "TeX",
        .text => "Text",
        .toml => "TOML",
        .typescript => "TypeScript",
        .vim_script => "Vim Script",
        .xml => "XML",
        .yacc => "Yacc",
        .yaml => "YAML",
        .zig => "Zig",
    };
}

test "detect language from filename" {
    try std.testing.expectEqual(Language.assembly, detect("src/startup.S").?);
    try std.testing.expectEqual(Language.assembly, detect("src/startup.asm").?);
    try std.testing.expectEqual(Language.awk, detect("scripts/report.awk").?);
    try std.testing.expectEqual(Language.c, detect("main.c").?);
    try std.testing.expectEqual(Language.c_cpp_header, detect("include/main.h").?);
    try std.testing.expectEqual(Language.c_cpp_header, detect("include/main.hh").?);
    try std.testing.expectEqual(Language.c_cpp_header, detect("include/main.hpp").?);
    try std.testing.expectEqual(Language.c_cpp_header, detect("include/main.hxx").?);
    try std.testing.expectEqual(Language.clojure, detect("src/core.clj").?);
    try std.testing.expectEqual(Language.clojure, detect("src/app.cljs").?);
    try std.testing.expectEqual(Language.csharp, detect("src/app.cs").?);
    try std.testing.expectEqual(Language.cpp, detect("src/main.cpp").?);
    try std.testing.expectEqual(Language.csv, detect("data/report.csv").?);
    try std.testing.expectEqual(Language.css, detect("src/app.css").?);
    try std.testing.expectEqual(Language.dart, detect("lib/main.dart").?);
    try std.testing.expectEqual(Language.dockerfile, detect("Dockerfile").?);
    try std.testing.expectEqual(Language.dockerfile, detect("docker/app.dockerfile").?);
    try std.testing.expectEqual(Language.go, detect("main.go").?);
    try std.testing.expectEqual(Language.hcl, detect("main.tf").?);
    try std.testing.expectEqual(Language.hcl, detect("variables.tfvars").?);
    try std.testing.expectEqual(Language.html, detect("public/index.html").?);
    try std.testing.expectEqual(Language.java, detect("src/Main.java").?);
    try std.testing.expectEqual(Language.javascript, detect("src/app.js").?);
    try std.testing.expectEqual(Language.javascript, detect("src/app.jsx").?);
    try std.testing.expectEqual(Language.javascript, detect("src/app.mjs").?);
    try std.testing.expectEqual(Language.javascript, detect("src/app.cjs").?);
    try std.testing.expectEqual(Language.jinja, detect("templates/index.jinja").?);
    try std.testing.expectEqual(Language.jinja, detect("templates/index.jinja2").?);
    try std.testing.expectEqual(Language.jinja, detect("templates/index.j2").?);
    try std.testing.expectEqual(Language.json, detect("package.json").?);
    try std.testing.expectEqual(Language.kotlin, detect("src/Main.kt").?);
    try std.testing.expectEqual(Language.kotlin, detect("build.gradle.kts").?);
    try std.testing.expectEqual(Language.lex, detect("parser/scanner.l").?);
    try std.testing.expectEqual(Language.lua, detect("init.lua").?);
    try std.testing.expectEqual(Language.makefile, detect("Makefile").?);
    try std.testing.expectEqual(Language.makefile, detect("rules.mk").?);
    try std.testing.expectEqual(Language.markdown, detect("README.md").?);
    try std.testing.expectEqual(Language.objective_c, detect("src/AppDelegate.m").?);
    try std.testing.expectEqual(Language.objective_c, detect("src/AppDelegate.mm").?);
    try std.testing.expectEqual(Language.perl, detect("script/report.pl").?);
    try std.testing.expectEqual(Language.perl, detect("lib/Zloc.pm").?);
    try std.testing.expectEqual(Language.php, detect("src/index.php").?);
    try std.testing.expectEqual(Language.python, detect("src/main.py").?);
    try std.testing.expectEqual(Language.r, detect("analysis.r").?);
    try std.testing.expectEqual(Language.r, detect("analysis.R").?);
    try std.testing.expectEqual(Language.ruby, detect("src/app.rb").?);
    try std.testing.expectEqual(Language.ruby, detect("Rakefile.rake").?);
    try std.testing.expectEqual(Language.ruby, detect("Gemfile").?);
    try std.testing.expectEqual(Language.rust, detect("src/main.rs").?);
    try std.testing.expectEqual(Language.sass, detect("src/app.scss").?);
    try std.testing.expectEqual(Language.sed, detect("scripts/edit.sed").?);
    try std.testing.expectEqual(Language.shell, detect("scripts/build.sh").?);
    try std.testing.expectEqual(Language.sql, detect("schema.sql").?);
    try std.testing.expectEqual(Language.svg, detect("assets/logo.svg").?);
    try std.testing.expectEqual(Language.swift, detect("Sources/App/main.swift").?);
    try std.testing.expectEqual(Language.tex, detect("paper.tex").?);
    try std.testing.expectEqual(Language.text, detect("notes.txt").?);
    try std.testing.expectEqual(Language.toml, detect("Cargo.toml").?);
    try std.testing.expectEqual(Language.typescript, detect("src/app.ts").?);
    try std.testing.expectEqual(Language.typescript, detect("src/app.tsx").?);
    try std.testing.expectEqual(Language.vim_script, detect(".vimrc").?);
    try std.testing.expectEqual(Language.vim_script, detect("plugin/zloc.vim").?);
    try std.testing.expectEqual(Language.xml, detect("feed.xml").?);
    try std.testing.expectEqual(Language.yacc, detect("parser/parser.y").?);
    try std.testing.expectEqual(Language.yaml, detect("config.yaml").?);
    try std.testing.expectEqual(Language.zig, detect("src/root.zig").?);

    try std.testing.expect(detect("README.unknown") == null);
}

fn expectCounts(language: Language, text: []const u8, blank: u64, comment: u64, code: u64) !void {
    const test_lexer = @import("lexer.zig");
    const counts = test_lexer.countWithSyntax(syntaxFor(language), text);

    try std.testing.expectEqual(blank, counts.blank);
    try std.testing.expectEqual(comment, counts.comment);
    try std.testing.expectEqual(code, counts.code);
}

test "Assembly code" {
    const text =
        \\.global _start
        \\
        \\; line comment
        \\_start:
        \\    mov r0, #1
        \\    .asciz "https://example.com"
    ;

    try expectCounts(.assembly, text, 1, 1, 4);
}

test "Awk code" {
    const text =
        \\BEGIN {
        \\    url = "https://example.com"
        \\    # line comment
        \\    print url # trailing comment
        \\}
    ;

    try expectCounts(.awk, text, 0, 1, 4);
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

test "C/C++ Header code" {
    const text =
        \\#ifndef ZLOC_H
        \\#define ZLOC_H
        \\
        \\// line comment
        \\/*
        \\block comment
        \\
        \\*/
        \\int count_lines(const char *path); // trailing comment
        \\#endif
    ;

    try expectCounts(.c_cpp_header, text, 1, 5, 4);
}

test "C/C++ Header code with C++ constructs" {
    const text =
        \\#pragma once
        \\
        \\#include <string>
        \\
        \\namespace zloc {
        \\// class comment
        \\template <typename T>
        \\class Counter {
        \\public:
        \\    T count(const std::string &path);
        \\};
        \\}
    ;

    try expectCounts(.c_cpp_header, text, 2, 1, 9);
}

test "Clojure code" {
    const text =
        \\(ns app.core)
        \\
        \\; line comment
        \\(def url "https://example.com") ; trailing comment
    ;

    try expectCounts(.clojure, text, 1, 1, 2);
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

test "CSV code" {
    const text =
        \\name,value
        \\"zloc","1"
        \\
    ;

    try expectCounts(.csv, text, 1, 0, 2);
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

test "Dart code" {
    const text =
        \\void main() {
        \\
        \\  // line comment
        \\  /*
        \\  block comment
        \\
        \\  */
        \\  final message = """// not a comment
        \\still string content""";
        \\  print(message); // trailing comment
        \\}
    ;

    try expectCounts(.dart, text, 1, 5, 5);
}

test "Dockerfile code" {
    const text =
        \\FROM alpine:latest
        \\
        \\# line comment
        \\RUN echo "https://example.com" # trailing comment
    ;

    try expectCounts(.dockerfile, text, 1, 1, 2);
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

test "HCL code" {
    const text =
        \\resource "aws_instance" "web" {
        \\
        \\  # hash comment
        \\  // slash comment
        \\  /*
        \\  block comment
        \\
        \\  */
        \\  ami = "ami-123"
        \\}
    ;

    try expectCounts(.hcl, text, 1, 6, 3);
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

test "Jinja code" {
    const text =
        \\<html>
        \\{# comment
        \\middle
        \\#}
        \\{{ url }}
    ;

    try expectCounts(.jinja, text, 0, 3, 2);
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

test "Kotlin code" {
    const text =
        \\fun main() {
        \\
        \\    // line comment
        \\    /*
        \\    block comment
        \\
        \\    */
        \\    val text = """// not a comment
        \\still string content"""
        \\    println(text) // trailing comment
        \\}
    ;

    try expectCounts(.kotlin, text, 1, 5, 5);
}

test "Lex code" {
    const text =
        \\%{
        \\#include <stdio.h>
        \\%}
        \\/* comment */
        \\%%
        \\[0-9]+    return NUMBER;
        \\%%
    ;

    try expectCounts(.lex, text, 0, 1, 6);
}

test "Lua code" {
    const text =
        \\local url = "https://example.com"
        \\
        \\-- line comment
        \\--[[
        \\block comment
        \\
        \\]]
        \\print(url) -- trailing comment
    ;

    try expectCounts(.lua, text, 1, 5, 2);
}

test "Makefile code" {
    const text =
        \\build:
        \\
        \\# line comment
        \\    echo "https://example.com" # trailing comment
    ;

    try expectCounts(.makefile, text, 1, 1, 2);
}

test "Markdown code" {
    const text =
        \\# Title
        \\
        \\<!-- comment
        \\middle
        \\-->
        \\Text
    ;

    try expectCounts(.markdown, text, 1, 3, 2);
}

test "Objective-C code" {
    const text =
        \\#import <Foundation/Foundation.h>
        \\
        \\// line comment
        \\/*
        \\block comment
        \\
        \\*/
        \\int main(void) {
        \\    NSLog(@"https://example.com"); // trailing comment
        \\}
    ;

    try expectCounts(.objective_c, text, 1, 5, 4);
}

test "Perl code" {
    const text =
        \\my $url = "https://example.com";
        \\
        \\# line comment
        \\=pod
        \\block comment
        \\
        \\=cut
        \\print $url; # trailing comment
    ;

    try expectCounts(.perl, text, 1, 5, 2);
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

test "R code" {
    const text =
        \\url <- "https://example.com"
        \\
        \\# line comment
        \\print(url) # trailing comment
    ;

    try expectCounts(.r, text, 1, 1, 2);
}

test "Ruby code" {
    const text =
        \\url = "https://example.com"
        \\
        \\# line comment
        \\=begin
        \\block comment
        \\
        \\=end
        \\puts url # trailing comment
    ;

    try expectCounts(.ruby, text, 1, 5, 2);
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

test "sed code" {
    const text =
        \\s/foo/bar/
        \\# line comment
        \\/thing/d
    ;

    try expectCounts(.sed, text, 0, 1, 2);
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

test "SVG code" {
    const text =
        \\<svg>
        \\<!-- comment
        \\middle
        \\-->
        \\<path d="M0 0"/>
        \\</svg>
    ;

    try expectCounts(.svg, text, 0, 3, 3);
}

test "Swift code" {
    const text =
        \\let url = "https://example.com"
        \\// line comment
        \\/*
        \\outer
        \\/*
        \\inner
        \\*/
        \\outer again
        \\*/
        \\let text = """// not a comment
        \\still string content"""
        \\print(text) // trailing comment
    ;

    try expectCounts(.swift, text, 0, 8, 4);
}

test "TeX code" {
    const text =
        \\\documentclass{article}
        \\
        \\% line comment
        \\\begin{document}
        \\Hello % trailing comment
        \\\end{document}
    ;

    try expectCounts(.tex, text, 1, 1, 3);
}

test "Text code" {
    const text =
        \\first line
        \\
        \\second line
    ;

    try expectCounts(.text, text, 1, 0, 2);
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

test "Vim Script code" {
    const text =
        \\let g:zloc = 'https://example.com'
        \\
        \\" line comment
        \\set number " trailing comment
    ;

    try expectCounts(.vim_script, text, 1, 1, 2);
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

test "Yacc code" {
    const text =
        \\%{
        \\#include <stdio.h>
        \\%}
        \\/* comment */
        \\%%
        \\expr: NUMBER ;
        \\%%
    ;

    try expectCounts(.yacc, text, 0, 1, 6);
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
