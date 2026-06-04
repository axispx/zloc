# Development

This document covers the technical details for working on `zloc`.

## Build

Build the executable locally:

```sh
zig build
```

Run tests:

```sh
zig build test
```

Add or update tests with code changes. Language changes should include detection tests and counting tests for comments, strings, blank lines, and mixed code/comment lines. Lexer changes should include focused tests in `src/lexer.zig` for the scanner behavior being changed.

Build an optimized release binary:

```sh
zig build -Doptimize=ReleaseFast
```

## Project Structure

- `src/args.zig`: CLI argument parsing
- `src/root.zig`: public API and CLI entry point
- `src/languages.zig`: language registry, syntax selection, and extension detection
- `src/syntax.zig`: lexer rule definitions
- `src/lexer.zig`: generic syntax-driven lexer
- `src/walker.zig`: file and directory discovery
- `src/report.zig`: aggregation and table output

## Language Detection

Language detection is defined in `src/languages.zig`.

Exact filename matches live in `filename_languages`:

```zig
const filename_languages = std.StaticStringMap(Language).initComptime(.{
    .{ "Makefile", .makefile },
});
```

Extension matches live in `extension_languages`:

```zig
const extension_languages = std.StaticStringMap(Language).initComptime(.{
    .{ ".zig", .zig },
});
```

Exact filenames are checked before extensions.

## Syntax Rules

Syntax rules are defined in `src/syntax.zig` and used from `src/languages.zig`.

- `line_comments`: markers that comment out the rest of a line, like `//` or `#`
- `block_comments`: start/end markers for comments that can span lines, like `/* ... */`
- `quoted`: strings or character literals where comment markers should be ignored
- `line_strings`: line-based string markers, used for syntax like Zig multiline string lines

Example:

```zig
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
```

## Lexer Tests

Add focused tests in `src/lexer.zig` when changing scanner behavior.

Useful cases include:

- line comments
- block comments
- overlapping block and line comment markers
- quoted strings containing comment markers
- multiline quoted strings
- line strings
- nested block comments
- blank lines inside comments or strings
- mixed code/comment lines

## Adding Language Support

1. Add the language to the `Language` enum:

```zig
pub const Language = enum {
    c,
    go,
    zig,
};
```

2. Define a syntax spec:

```zig
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
```

3. Add it to `supported_languages`:

```zig
pub const supported_languages = [_]Language{
    .c,
    .go,
    .zig,
};
```

4. Add the syntax spec to `specs`:

```zig
.{
    .language = .zig,
    .syntax = zig_syntax,
},
```

5. Register extensions or exact filenames in the detection maps:

```zig
const extension_languages = std.StaticStringMap(Language).initComptime(.{
    .{ ".zig", .zig },
});
```

6. Add a display name in `name()`:

```zig
.zig => "Zig",
```

7. Add focused test cases in `src/languages.zig`:

- detection tests for each extension or exact filename
- counting tests for line comments, block comments, strings, blank lines, and mixed code/comment lines
- edge cases for multiline strings or nested comments when the language supports them

## Release Checklist

For each release:

- Run `zig fmt build.zig src/*.zig`
- Run `zig build test`
- Build release binary with `zig build -Doptimize=ReleaseFast`
- Tag a version, for example `v0.1.0`
- Create a GitHub release from the tag
