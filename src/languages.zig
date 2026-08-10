const std = @import("std");
const syntax = @import("syntax.zig");

// Supported languages
pub const Language = enum {
    assembly,
    astro,
    awk,
    batch,
    c,
    c_cpp_header,
    clojure,
    crystal,
    csharp,
    cpp,
    csv,
    css,
    d,
    dart,
    dockerfile,
    elixir,
    erlang,
    fsharp,
    gleam,
    go,
    graphql,
    groovy,
    hcl,
    haskell,
    html,
    java,
    javascript,
    jinja,
    json,
    julia,
    kotlin,
    lex,
    lua,
    makefile,
    markdown,
    nim,
    objective_c,
    ocaml,
    perl,
    php,
    powershell,
    python,
    r,
    ruby,
    rust,
    sass,
    scala,
    sed,
    shell,
    sql,
    svg,
    svelte,
    swift,
    tex,
    text,
    toml,
    typescript,
    verilog,
    vhdl,
    vim_script,
    xml,
    yacc,
    yaml,
    zig,
};

const LanguageSpec = struct {
    language: Language,
    syntax: syntax.SyntaxSpec,
};

pub const supported_languages = [_]Language{
    .assembly,
    .astro,
    .awk,
    .batch,
    .c,
    .c_cpp_header,
    .clojure,
    .crystal,
    .csharp,
    .cpp,
    .csv,
    .css,
    .d,
    .dart,
    .dockerfile,
    .elixir,
    .erlang,
    .fsharp,
    .gleam,
    .go,
    .graphql,
    .groovy,
    .hcl,
    .haskell,
    .html,
    .java,
    .javascript,
    .jinja,
    .json,
    .julia,
    .kotlin,
    .lex,
    .lua,
    .makefile,
    .markdown,
    .nim,
    .objective_c,
    .ocaml,
    .perl,
    .php,
    .powershell,
    .python,
    .r,
    .ruby,
    .rust,
    .sass,
    .scala,
    .sed,
    .shell,
    .sql,
    .svg,
    .svelte,
    .swift,
    .tex,
    .text,
    .toml,
    .typescript,
    .verilog,
    .vhdl,
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

pub const astro_syntax = html_syntax;

pub const awk_syntax = syntax.SyntaxSpec{
    .line_comments = &.{.{ .marker = "#" }},
    .quoted = &.{
        .{ .start = "\"", .end = "\"", .escape = '\\' },
    },
};

pub const batch_syntax = syntax.SyntaxSpec{
    .line_comments = &.{
        .{ .marker = "::" },
        .{ .marker = "REM " },
        .{ .marker = "rem " },
    },
    .quoted = &.{
        .{ .start = "\"", .end = "\"" },
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

pub const crystal_syntax = ruby_syntax;
pub const csharp_syntax = c_syntax;
pub const cpp_syntax = c_syntax;

pub const d_syntax = syntax.SyntaxSpec{
    .line_comments = &.{.{ .marker = "//" }},
    .block_comments = &.{
        .{ .start = "/*", .end = "*/" },
        .{ .start = "/+", .end = "+/", .nested = true },
    },
    .quoted = &.{
        .{ .start = "\"", .end = "\"", .escape = '\\' },
        .{ .start = "'", .end = "'", .escape = '\\' },
        .{ .start = "`", .end = "`", .multiline = true },
    },
};

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

pub const elixir_syntax = syntax.SyntaxSpec{
    .line_comments = &.{.{ .marker = "#" }},
    .quoted = &.{
        .{ .start = "\"\"\"", .end = "\"\"\"", .escape = '\\', .multiline = true },
        .{ .start = "'''", .end = "'''", .escape = '\\', .multiline = true },
        .{ .start = "\"", .end = "\"", .escape = '\\' },
        .{ .start = "'", .end = "'", .escape = '\\' },
    },
};

pub const erlang_syntax = syntax.SyntaxSpec{
    .line_comments = &.{.{ .marker = "%" }},
    .quoted = &.{
        .{ .start = "\"", .end = "\"", .escape = '\\' },
        .{ .start = "'", .end = "'", .escape = '\\' },
    },
};

pub const fsharp_syntax = syntax.SyntaxSpec{
    .line_comments = &.{.{ .marker = "//" }},
    .block_comments = &.{.{ .start = "(*", .end = "*)" }},
    .quoted = &.{
        .{ .start = "\"\"\"", .end = "\"\"\"", .multiline = true },
        .{ .start = "\"", .end = "\"", .escape = '\\' },
    },
};

pub const gleam_syntax = syntax.SyntaxSpec{
    .line_comments = &.{.{ .marker = "//" }},
    .quoted = &.{
        .{ .start = "\"", .end = "\"", .escape = '\\' },
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

pub const graphql_syntax = syntax.SyntaxSpec{
    .line_comments = &.{.{ .marker = "#" }},
    .quoted = &.{
        .{ .start = "\"\"\"", .end = "\"\"\"", .multiline = true },
        .{ .start = "\"", .end = "\"", .escape = '\\' },
    },
};

pub const groovy_syntax = syntax.SyntaxSpec{
    .line_comments = &.{.{ .marker = "//" }},
    .block_comments = &.{.{ .start = "/*", .end = "*/" }},
    .quoted = &.{
        .{ .start = "\"\"\"", .end = "\"\"\"", .escape = '\\', .multiline = true },
        .{ .start = "'''", .end = "'''", .escape = '\\', .multiline = true },
        .{ .start = "\"", .end = "\"", .escape = '\\' },
        .{ .start = "'", .end = "'", .escape = '\\' },
    },
};

pub const hcl_syntax = syntax.SyntaxSpec{
    .line_comments = &.{ .{ .marker = "#" }, .{ .marker = "//" } },
    .block_comments = &.{.{ .start = "/*", .end = "*/" }},
    .quoted = &.{
        .{ .start = "\"", .end = "\"", .escape = '\\' },
    },
};

pub const haskell_syntax = syntax.SyntaxSpec{
    .line_comments = &.{.{ .marker = "--" }},
    .block_comments = &.{.{ .start = "{-", .end = "-}", .nested = true }},
    .quoted = &.{
        .{ .start = "\"", .end = "\"", .escape = '\\' },
        .{ .start = "'", .end = "'", .escape = '\\' },
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

pub const julia_syntax = syntax.SyntaxSpec{
    .line_comments = &.{.{ .marker = "#" }},
    .block_comments = &.{.{ .start = "#=", .end = "=#" }},
    .quoted = &.{
        .{ .start = "\"\"\"", .end = "\"\"\"", .escape = '\\', .multiline = true },
        .{ .start = "\"", .end = "\"", .escape = '\\' },
        .{ .start = "'", .end = "'", .escape = '\\' },
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

pub const nim_syntax = syntax.SyntaxSpec{
    .line_comments = &.{.{ .marker = "#" }},
    .block_comments = &.{.{ .start = "#[", .end = "]#" }},
    .quoted = &.{
        .{ .start = "\"\"\"", .end = "\"\"\"", .multiline = true },
        .{ .start = "\"", .end = "\"", .escape = '\\' },
        .{ .start = "'", .end = "'", .escape = '\\' },
    },
};

pub const objective_c_syntax = c_syntax;

pub const ocaml_syntax = syntax.SyntaxSpec{
    .block_comments = &.{.{ .start = "(*", .end = "*)", .nested = true }},
    .quoted = &.{
        .{ .start = "\"", .end = "\"", .escape = '\\' },
        .{ .start = "'", .end = "'", .escape = '\\' },
    },
};

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

pub const powershell_syntax = syntax.SyntaxSpec{
    .line_comments = &.{.{ .marker = "#" }},
    .block_comments = &.{.{ .start = "<#", .end = "#>" }},
    .quoted = &.{
        .{ .start = "\"", .end = "\"", .escape = '`' },
        .{ .start = "'", .end = "'" },
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

pub const scala_syntax = syntax.SyntaxSpec{
    .line_comments = &.{.{ .marker = "//" }},
    .block_comments = &.{.{ .start = "/*", .end = "*/" }},
    .quoted = &.{
        .{ .start = "\"\"\"", .end = "\"\"\"", .multiline = true },
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

pub const svelte_syntax = html_syntax;

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

pub const verilog_syntax = syntax.SyntaxSpec{
    .line_comments = &.{.{ .marker = "//" }},
    .block_comments = &.{.{ .start = "/*", .end = "*/" }},
    .quoted = &.{
        .{ .start = "\"", .end = "\"", .escape = '\\' },
    },
};

pub const vhdl_syntax = syntax.SyntaxSpec{
    .line_comments = &.{.{ .marker = "--" }},
    .quoted = &.{
        .{ .start = "\"", .end = "\"" },
    },
};

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
        .syntax = assembly_syntax,
    },
    .{
        .language = .astro,
        .syntax = astro_syntax,
    },
    .{
        .language = .awk,
        .syntax = awk_syntax,
    },
    .{
        .language = .batch,
        .syntax = batch_syntax,
    },
    .{
        .language = .c,
        .syntax = c_syntax,
    },
    .{
        .language = .c_cpp_header,
        .syntax = c_cpp_header_syntax,
    },
    .{
        .language = .clojure,
        .syntax = clojure_syntax,
    },
    .{
        .language = .crystal,
        .syntax = crystal_syntax,
    },
    .{
        .language = .csharp,
        .syntax = csharp_syntax,
    },
    .{
        .language = .cpp,
        .syntax = cpp_syntax,
    },
    .{
        .language = .csv,
        .syntax = csv_syntax,
    },
    .{
        .language = .css,
        .syntax = css_syntax,
    },
    .{
        .language = .d,
        .syntax = d_syntax,
    },
    .{
        .language = .dart,
        .syntax = dart_syntax,
    },
    .{
        .language = .dockerfile,
        .syntax = dockerfile_syntax,
    },
    .{
        .language = .elixir,
        .syntax = elixir_syntax,
    },
    .{
        .language = .erlang,
        .syntax = erlang_syntax,
    },
    .{
        .language = .fsharp,
        .syntax = fsharp_syntax,
    },
    .{
        .language = .gleam,
        .syntax = gleam_syntax,
    },
    .{
        .language = .go,
        .syntax = go_syntax,
    },
    .{
        .language = .graphql,
        .syntax = graphql_syntax,
    },
    .{
        .language = .groovy,
        .syntax = groovy_syntax,
    },
    .{
        .language = .hcl,
        .syntax = hcl_syntax,
    },
    .{
        .language = .haskell,
        .syntax = haskell_syntax,
    },
    .{
        .language = .html,
        .syntax = html_syntax,
    },
    .{
        .language = .java,
        .syntax = java_syntax,
    },
    .{
        .language = .javascript,
        .syntax = javascript_syntax,
    },
    .{
        .language = .jinja,
        .syntax = jinja_syntax,
    },
    .{
        .language = .json,
        .syntax = json_syntax,
    },
    .{
        .language = .julia,
        .syntax = julia_syntax,
    },
    .{
        .language = .kotlin,
        .syntax = kotlin_syntax,
    },
    .{
        .language = .lex,
        .syntax = lex_syntax,
    },
    .{
        .language = .lua,
        .syntax = lua_syntax,
    },
    .{
        .language = .makefile,
        .syntax = makefile_syntax,
    },
    .{
        .language = .markdown,
        .syntax = markdown_syntax,
    },
    .{
        .language = .nim,
        .syntax = nim_syntax,
    },
    .{
        .language = .objective_c,
        .syntax = objective_c_syntax,
    },
    .{
        .language = .ocaml,
        .syntax = ocaml_syntax,
    },
    .{
        .language = .perl,
        .syntax = perl_syntax,
    },
    .{
        .language = .php,
        .syntax = php_syntax,
    },
    .{
        .language = .powershell,
        .syntax = powershell_syntax,
    },
    .{
        .language = .python,
        .syntax = python_syntax,
    },
    .{
        .language = .r,
        .syntax = r_syntax,
    },
    .{
        .language = .ruby,
        .syntax = ruby_syntax,
    },
    .{
        .language = .rust,
        .syntax = rust_syntax,
    },
    .{
        .language = .sass,
        .syntax = sass_syntax,
    },
    .{
        .language = .scala,
        .syntax = scala_syntax,
    },
    .{
        .language = .sed,
        .syntax = sed_syntax,
    },
    .{
        .language = .shell,
        .syntax = shell_syntax,
    },
    .{
        .language = .sql,
        .syntax = sql_syntax,
    },
    .{
        .language = .svg,
        .syntax = svg_syntax,
    },
    .{
        .language = .svelte,
        .syntax = svelte_syntax,
    },
    .{
        .language = .swift,
        .syntax = swift_syntax,
    },
    .{
        .language = .tex,
        .syntax = tex_syntax,
    },
    .{
        .language = .text,
        .syntax = text_syntax,
    },
    .{
        .language = .toml,
        .syntax = toml_syntax,
    },
    .{
        .language = .typescript,
        .syntax = typescript_syntax,
    },
    .{
        .language = .verilog,
        .syntax = verilog_syntax,
    },
    .{
        .language = .vhdl,
        .syntax = vhdl_syntax,
    },
    .{
        .language = .vim_script,
        .syntax = vim_script_syntax,
    },
    .{
        .language = .xml,
        .syntax = xml_syntax,
    },
    .{
        .language = .yacc,
        .syntax = yacc_syntax,
    },
    .{
        .language = .yaml,
        .syntax = yaml_syntax,
    },
    .{
        .language = .zig,
        .syntax = zig_syntax,
    },
};

const filename_languages = std.StaticStringMap(Language).initComptime(.{
    .{ ".gvimrc", .vim_script },
    .{ ".vimrc", .vim_script },
    .{ "_gvimrc", .vim_script },
    .{ "_vimrc", .vim_script },
    .{ "build.gradle", .groovy },
    .{ "Dockerfile", .dockerfile },
    .{ "dockerfile", .dockerfile },
    .{ "Gemfile", .ruby },
    .{ "GNUmakefile", .makefile },
    .{ "Makefile", .makefile },
    .{ "makefile", .makefile },
    .{ "Rakefile", .ruby },
    .{ "settings.gradle", .groovy },
});

const extension_languages = std.StaticStringMap(Language).initComptime(.{
    .{ ".asm", .assembly },
    .{ ".astro", .astro },
    .{ ".awk", .awk },
    .{ ".bash", .shell },
    .{ ".bat", .batch },
    .{ ".c", .c },
    .{ ".cc", .cpp },
    .{ ".cjs", .javascript },
    .{ ".clj", .clojure },
    .{ ".cljc", .clojure },
    .{ ".cljs", .clojure },
    .{ ".cls", .tex },
    .{ ".cmd", .batch },
    .{ ".cpp", .cpp },
    .{ ".cr", .crystal },
    .{ ".cs", .csharp },
    .{ ".css", .css },
    .{ ".csv", .csv },
    .{ ".cts", .typescript },
    .{ ".cxx", .cpp },
    .{ ".d", .d },
    .{ ".dart", .dart },
    .{ ".dockerfile", .dockerfile },
    .{ ".edn", .clojure },
    .{ ".erl", .erlang },
    .{ ".ex", .elixir },
    .{ ".exs", .elixir },
    .{ ".fish", .shell },
    .{ ".fs", .fsharp },
    .{ ".fsi", .fsharp },
    .{ ".fsx", .fsharp },
    .{ ".gleam", .gleam },
    .{ ".go", .go },
    .{ ".gql", .graphql },
    .{ ".gradle", .groovy },
    .{ ".graphql", .graphql },
    .{ ".groovy", .groovy },
    .{ ".h", .c_cpp_header },
    .{ ".hcl", .hcl },
    .{ ".hh", .c_cpp_header },
    .{ ".hpp", .c_cpp_header },
    .{ ".hrl", .erlang },
    .{ ".hs", .haskell },
    .{ ".htm", .html },
    .{ ".html", .html },
    .{ ".hxx", .c_cpp_header },
    .{ ".j2", .jinja },
    .{ ".java", .java },
    .{ ".jinja", .jinja },
    .{ ".jinja2", .jinja },
    .{ ".jl", .julia },
    .{ ".js", .javascript },
    .{ ".json", .json },
    .{ ".jsx", .javascript },
    .{ ".kt", .kotlin },
    .{ ".kts", .kotlin },
    .{ ".l", .lex },
    .{ ".lhs", .haskell },
    .{ ".ll", .lex },
    .{ ".lua", .lua },
    .{ ".m", .objective_c },
    .{ ".markdown", .markdown },
    .{ ".md", .markdown },
    .{ ".mdown", .markdown },
    .{ ".mjs", .javascript },
    .{ ".mk", .makefile },
    .{ ".mkd", .markdown },
    .{ ".ml", .ocaml },
    .{ ".mli", .ocaml },
    .{ ".mm", .objective_c },
    .{ ".mts", .typescript },
    .{ ".nim", .nim },
    .{ ".perl", .perl },
    .{ ".php", .php },
    .{ ".phtml", .php },
    .{ ".pl", .perl },
    .{ ".pm", .perl },
    .{ ".pod", .perl },
    .{ ".ps1", .powershell },
    .{ ".psd1", .powershell },
    .{ ".psgi", .perl },
    .{ ".psm1", .powershell },
    .{ ".py", .python },
    .{ ".pyw", .python },
    .{ ".R", .r },
    .{ ".r", .r },
    .{ ".rake", .ruby },
    .{ ".rb", .ruby },
    .{ ".rs", .rust },
    .{ ".S", .assembly },
    .{ ".s", .assembly },
    .{ ".sass", .sass },
    .{ ".sc", .scala },
    .{ ".scala", .scala },
    .{ ".scss", .sass },
    .{ ".sed", .sed },
    .{ ".sh", .shell },
    .{ ".sql", .sql },
    .{ ".sty", .tex },
    .{ ".sv", .verilog },
    .{ ".svelte", .svelte },
    .{ ".svg", .svg },
    .{ ".svh", .verilog },
    .{ ".swift", .swift },
    .{ ".t", .perl },
    .{ ".tex", .tex },
    .{ ".text", .text },
    .{ ".tf", .hcl },
    .{ ".tfvars", .hcl },
    .{ ".toml", .toml },
    .{ ".ts", .typescript },
    .{ ".tsx", .typescript },
    .{ ".txt", .text },
    .{ ".v", .verilog },
    .{ ".vhd", .vhdl },
    .{ ".vhdl", .vhdl },
    .{ ".vh", .verilog },
    .{ ".vim", .vim_script },
    .{ ".vimrc", .vim_script },
    .{ ".xml", .xml },
    .{ ".y", .yacc },
    .{ ".yaml", .yaml },
    .{ ".yml", .yaml },
    .{ ".yy", .yacc },
    .{ ".zig", .zig },
    .{ ".zsh", .shell },
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
        .astro => "Astro",
        .awk => "Awk",
        .batch => "Batch",
        .c => "C",
        .c_cpp_header => "C/C++ Header",
        .clojure => "Clojure",
        .crystal => "Crystal",
        .csharp => "C#",
        .cpp => "C++",
        .csv => "CSV",
        .css => "CSS",
        .d => "D",
        .dart => "Dart",
        .dockerfile => "Dockerfile",
        .elixir => "Elixir",
        .erlang => "Erlang",
        .fsharp => "F#",
        .gleam => "Gleam",
        .go => "Go",
        .graphql => "GraphQL",
        .groovy => "Groovy",
        .hcl => "HCL",
        .haskell => "Haskell",
        .html => "HTML",
        .java => "Java",
        .javascript => "JavaScript",
        .jinja => "Jinja",
        .json => "JSON",
        .julia => "Julia",
        .kotlin => "Kotlin",
        .lex => "Lex",
        .lua => "Lua",
        .makefile => "Makefile",
        .markdown => "Markdown",
        .nim => "Nim",
        .objective_c => "Objective-C",
        .ocaml => "OCaml",
        .perl => "Perl",
        .php => "PHP",
        .powershell => "PowerShell",
        .python => "Python",
        .r => "R",
        .ruby => "Ruby",
        .rust => "Rust",
        .sass => "Sass",
        .scala => "Scala",
        .sed => "sed",
        .shell => "Shell",
        .sql => "SQL",
        .svg => "SVG",
        .svelte => "Svelte",
        .swift => "Swift",
        .tex => "TeX",
        .text => "Text",
        .toml => "TOML",
        .typescript => "TypeScript",
        .verilog => "Verilog",
        .vhdl => "VHDL",
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
    try std.testing.expectEqual(Language.astro, detect("src/page.astro").?);
    try std.testing.expectEqual(Language.awk, detect("scripts/report.awk").?);
    try std.testing.expectEqual(Language.batch, detect("scripts/build.bat").?);
    try std.testing.expectEqual(Language.batch, detect("scripts/build.cmd").?);
    try std.testing.expectEqual(Language.c, detect("main.c").?);
    try std.testing.expectEqual(Language.c_cpp_header, detect("include/main.h").?);
    try std.testing.expectEqual(Language.c_cpp_header, detect("include/main.hh").?);
    try std.testing.expectEqual(Language.c_cpp_header, detect("include/main.hpp").?);
    try std.testing.expectEqual(Language.c_cpp_header, detect("include/main.hxx").?);
    try std.testing.expectEqual(Language.clojure, detect("src/core.clj").?);
    try std.testing.expectEqual(Language.clojure, detect("src/app.cljs").?);
    try std.testing.expectEqual(Language.crystal, detect("src/app.cr").?);
    try std.testing.expectEqual(Language.csharp, detect("src/app.cs").?);
    try std.testing.expectEqual(Language.cpp, detect("src/main.cpp").?);
    try std.testing.expectEqual(Language.csv, detect("data/report.csv").?);
    try std.testing.expectEqual(Language.css, detect("src/app.css").?);
    try std.testing.expectEqual(Language.d, detect("src/app.d").?);
    try std.testing.expectEqual(Language.dart, detect("lib/main.dart").?);
    try std.testing.expectEqual(Language.dockerfile, detect("Dockerfile").?);
    try std.testing.expectEqual(Language.dockerfile, detect("docker/app.dockerfile").?);
    try std.testing.expectEqual(Language.elixir, detect("lib/app.ex").?);
    try std.testing.expectEqual(Language.elixir, detect("test/app_test.exs").?);
    try std.testing.expectEqual(Language.erlang, detect("src/app.erl").?);
    try std.testing.expectEqual(Language.erlang, detect("include/app.hrl").?);
    try std.testing.expectEqual(Language.fsharp, detect("src/App.fs").?);
    try std.testing.expectEqual(Language.fsharp, detect("src/App.fsi").?);
    try std.testing.expectEqual(Language.fsharp, detect("src/App.fsx").?);
    try std.testing.expectEqual(Language.gleam, detect("src/app.gleam").?);
    try std.testing.expectEqual(Language.go, detect("main.go").?);
    try std.testing.expectEqual(Language.graphql, detect("schema.graphql").?);
    try std.testing.expectEqual(Language.graphql, detect("schema.gql").?);
    try std.testing.expectEqual(Language.groovy, detect("src/App.groovy").?);
    try std.testing.expectEqual(Language.groovy, detect("build.gradle").?);
    try std.testing.expectEqual(Language.hcl, detect("main.tf").?);
    try std.testing.expectEqual(Language.hcl, detect("variables.tfvars").?);
    try std.testing.expectEqual(Language.haskell, detect("src/Main.hs").?);
    try std.testing.expectEqual(Language.haskell, detect("src/Main.lhs").?);
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
    try std.testing.expectEqual(Language.julia, detect("src/app.jl").?);
    try std.testing.expectEqual(Language.kotlin, detect("src/Main.kt").?);
    try std.testing.expectEqual(Language.kotlin, detect("build.gradle.kts").?);
    try std.testing.expectEqual(Language.lex, detect("parser/scanner.l").?);
    try std.testing.expectEqual(Language.lua, detect("init.lua").?);
    try std.testing.expectEqual(Language.makefile, detect("Makefile").?);
    try std.testing.expectEqual(Language.makefile, detect("rules.mk").?);
    try std.testing.expectEqual(Language.markdown, detect("README.md").?);
    try std.testing.expectEqual(Language.nim, detect("src/app.nim").?);
    try std.testing.expectEqual(Language.objective_c, detect("src/AppDelegate.m").?);
    try std.testing.expectEqual(Language.objective_c, detect("src/AppDelegate.mm").?);
    try std.testing.expectEqual(Language.ocaml, detect("src/app.ml").?);
    try std.testing.expectEqual(Language.ocaml, detect("src/app.mli").?);
    try std.testing.expectEqual(Language.perl, detect("script/report.pl").?);
    try std.testing.expectEqual(Language.perl, detect("lib/Zloc.pm").?);
    try std.testing.expectEqual(Language.php, detect("src/index.php").?);
    try std.testing.expectEqual(Language.php, detect("src/index.phtml").?);
    try std.testing.expectEqual(Language.powershell, detect("scripts/build.ps1").?);
    try std.testing.expectEqual(Language.powershell, detect("scripts/module.psm1").?);
    try std.testing.expectEqual(Language.powershell, detect("scripts/data.psd1").?);
    try std.testing.expectEqual(Language.python, detect("src/main.py").?);
    try std.testing.expectEqual(Language.r, detect("analysis.r").?);
    try std.testing.expectEqual(Language.r, detect("analysis.R").?);
    try std.testing.expectEqual(Language.ruby, detect("src/app.rb").?);
    try std.testing.expectEqual(Language.ruby, detect("Rakefile.rake").?);
    try std.testing.expectEqual(Language.ruby, detect("Gemfile").?);
    try std.testing.expectEqual(Language.rust, detect("src/main.rs").?);
    try std.testing.expectEqual(Language.sass, detect("src/app.scss").?);
    try std.testing.expectEqual(Language.scala, detect("src/Main.scala").?);
    try std.testing.expectEqual(Language.scala, detect("src/Main.sc").?);
    try std.testing.expectEqual(Language.sed, detect("scripts/edit.sed").?);
    try std.testing.expectEqual(Language.shell, detect("scripts/build.sh").?);
    try std.testing.expectEqual(Language.sql, detect("schema.sql").?);
    try std.testing.expectEqual(Language.svg, detect("assets/logo.svg").?);
    try std.testing.expectEqual(Language.svelte, detect("src/App.svelte").?);
    try std.testing.expectEqual(Language.swift, detect("Sources/App/main.swift").?);
    try std.testing.expectEqual(Language.tex, detect("paper.tex").?);
    try std.testing.expectEqual(Language.text, detect("notes.txt").?);
    try std.testing.expectEqual(Language.toml, detect("Cargo.toml").?);
    try std.testing.expectEqual(Language.typescript, detect("src/app.ts").?);
    try std.testing.expectEqual(Language.typescript, detect("src/app.tsx").?);
    try std.testing.expectEqual(Language.verilog, detect("rtl/core.v").?);
    try std.testing.expectEqual(Language.verilog, detect("rtl/core.vh").?);
    try std.testing.expectEqual(Language.verilog, detect("rtl/core.sv").?);
    try std.testing.expectEqual(Language.verilog, detect("rtl/core.svh").?);
    try std.testing.expectEqual(Language.vhdl, detect("rtl/core.vhd").?);
    try std.testing.expectEqual(Language.vhdl, detect("rtl/core.vhdl").?);
    try std.testing.expectEqual(Language.vim_script, detect(".vimrc").?);
    try std.testing.expectEqual(Language.vim_script, detect("plugin/zloc.vim").?);
    try std.testing.expectEqual(Language.xml, detect("feed.xml").?);
    try std.testing.expectEqual(Language.yacc, detect("parser/parser.y").?);
    try std.testing.expectEqual(Language.yaml, detect("config.yaml").?);
    try std.testing.expectEqual(Language.zig, detect("src/root.zig").?);

    try std.testing.expect(detect("README.unknown") == null);
}

test "new language syntax rules" {
    try expectCounts(.astro,
        \\<h1>Hello</h1>
        \\<!-- comment -->
        \\<p>World</p>
    , 0, 1, 2);

    try expectCounts(.batch,
        \\@echo off
        \\REM comment
        \\echo done
    , 0, 1, 2);

    try expectCounts(.crystal,
        \\puts "https://example.com"
        \\# comment
        \\puts "done"
    , 0, 1, 2);

    try expectCounts(.d,
        \\import std.stdio;
        \\/+ comment +/
        \\writeln("done");
    , 0, 1, 2);

    try expectCounts(.elixir,
        \\IO.puts("https://example.com")
        \\# comment
        \\IO.puts("done")
    , 0, 1, 2);

    try expectCounts(.erlang,
        \\main() ->
        \\% comment
        \\ok.
    , 0, 1, 2);

    try expectCounts(.fsharp,
        \\let url = "https://example.com"
        \\// comment
        \\printfn "%s" url
    , 0, 1, 2);

    try expectCounts(.gleam,
        \\pub fn main() {
        \\// comment
        \\  io.println("done")
        \\}
    , 0, 1, 3);

    try expectCounts(.graphql,
        \\type Query {
        \\# comment
        \\  user: User
    , 0, 1, 2);

    try expectCounts(.groovy,
        \\def url = "https://example.com"
        \\// comment
        \\println url
    , 0, 1, 2);

    try expectCounts(.haskell,
        \\main = do
        \\-- comment
        \\  putStrLn "done"
    , 0, 1, 2);

    try expectCounts(.julia,
        \\url = "https://example.com"
        \\# comment
        \\println(url)
    , 0, 1, 2);

    try expectCounts(.nim,
        \\let url = "https://example.com"
        \\# comment
        \\echo url
    , 0, 1, 2);

    try expectCounts(.ocaml,
        \\let url = "https://example.com"
        \\(* comment *)
        \\print_endline url
    , 0, 1, 2);

    try expectCounts(.powershell,
        \\$url = "https://example.com"
        \\# comment
        \\Write-Output $url
    , 0, 1, 2);

    try expectCounts(.scala,
        \\val url = "https://example.com"
        \\// comment
        \\println(url)
    , 0, 1, 2);

    try expectCounts(.svelte,
        \\<script>let name = "zloc";</script>
        \\<!-- comment -->
        \\<h1>{name}</h1>
    , 0, 1, 2);

    try expectCounts(.verilog,
        \\module top;
        \\// comment
        \\endmodule
    , 0, 1, 2);

    try expectCounts(.vhdl,
        \\entity top is
        \\-- comment
        \\end top;
    , 0, 1, 2);
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

    try expectCounts(.csv, text, 0, 0, 2);
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

test "Elixir code" {
    const text =
        \\defmodule App do
        \\
        \\  # line comment
        \\  @doc """
        \\  multiline string
        \\  # not a comment
        \\  """
        \\  def main do
        \\    url = "https://example.com" # trailing comment
        \\    IO.puts(url)
        \\  end
        \\end
    ;

    try expectCounts(.elixir, text, 1, 1, 10);
}

test "Erlang code" {
    const text =
        \\-module(app).
        \\
        \\% line comment
        \\main() ->
        \\    Url = "https://example.com", % trailing comment
        \\    %% still a comment
        \\    io:format("~s~n", [Url]).
    ;

    try expectCounts(.erlang, text, 1, 2, 4);
}

test "Gleam code" {
    const text =
        \\import gleam/io
        \\
        \\// line comment
        \\/// doc comment
        \\pub fn main() {
        \\  let url = "https://example.com" // trailing comment
        \\  io.println(url)
        \\}
    ;

    try expectCounts(.gleam, text, 1, 2, 5);
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

    try expectCounts(.tex, text, 1, 1, 4);
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
