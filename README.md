# zloc

`zloc` is a small `cloc`-style command line tool written in Zig. It counts blank lines, comment lines, and code lines for source files.

## Status

`zloc` currently counts one or more file or directory paths. It detects the language from each file extension, runs a lightweight lexer for that language, and prints line counts.

For directory inputs inside a Git worktree, `zloc` uses `git ls-files` so ignored files are skipped by Git. Non-Git directories fall back to recursive filesystem traversal.

## Supported Languages

| Language   | Extensions                     |
| ---------- | ------------------------------ |
| C          | `.c`, `.h`                     |
| Go         | `.go`                          |
| JavaScript | `.js`, `.jsx`, `.mjs`, `.cjs` |
| TypeScript | `.ts`, `.tsx`, `.mts`, `.cts` |
| Zig        | `.zig`                         |

## Usage

Build the executable:

```sh
zig build
```

Count one or more files or directories:

```sh
zig build run -- src path/to/file.go
```

Example output:

```text
Language  Files  Blank  Comment  Code
-------------------------------------
Go            1      2        5     6
Zig           1      2        1     6
-------------------------------------
Total         2      4        6    12
```

Print line-by-line classifications for debugging:

```sh
zig build run -- --debug path/to/file.go
```

Print verbose output:

```sh
zig build run -- --verbose src README.md
```

## Development

Run tests:

```sh
zig build test
```

The main implementation is split across:

- `src/args.zig`: CLI argument parsing
- `src/root.zig`: public API and CLI entry point
- `src/languages.zig`: language metadata and extension detection
- `src/syntax.zig`: lexer rule definitions
- `src/lexer.zig`: generic syntax-driven lexer
- `src/walker.zig`: file and directory discovery
- `src/report.zig`: aggregation and table output

## Adding Language Support

Language support is defined in `src/languages.zig` using syntax rules from `src/syntax.zig`.

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

4. Register extensions and syntax in `specs`:

```zig
.{
    .language = .zig,
    .extensions = &.{".zig"},
    .syntax = zig_syntax,
},
```

5. Add a display name in `name()`:

```zig
.zig => "Zig",
```

6. Add focused tests in `src/root.zig` for comments, strings, blank lines, and mixed code/comment lines.

## License

MIT. See [LICENSE](LICENSE).
