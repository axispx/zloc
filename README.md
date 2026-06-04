# zloc

`zloc` is a small, blazingly fast ⚡ source code line counter written in Zig.

## Status

`zloc` counts one or more file or directory paths recursively. It detects the language from each file extension, runs a lightweight lexer for that language, and prints line counts.

For directory inputs inside a Git repository, `zloc` uses `git ls-files` so files are automatically filtered using `.gitignore`. Non-Git directories fall back to recursive filesystem traversal.

## Supported Languages

`zloc` supports 60+ languages. See the full list [here](src/languages.zig#L4).

## Install

Install `zloc` to `~/.local/bin`:

```sh
zig build -Doptimize=ReleaseFast --prefix ~/.local
```

Make sure `~/.local/bin` is in your `PATH`:

```sh
echo 'export PATH="$HOME/.local/bin:$PATH"' >> ~/.zshrc
source ~/.zshrc
```

## Usage

Count one or more files or directories:

```sh
zloc src path/to/file.go
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
zloc --debug path/to/file.go
```

Print verbose output:

```sh
zloc --verbose src README.md
```

## Development

Build the executable locally:

```sh
zig build
```

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
