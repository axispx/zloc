# zloc

`zloc` is a small `cloc`-style command line tool written in Zig. It counts blank lines, comment lines, and code lines for source files.

## Status

`zloc` is currently a single-file counter. It detects the language from the file extension, runs a lightweight lexer for that language, and prints line counts.

## Supported Languages

| Language | Extensions |
| -------- | ---------- |
| C        | `.c`, `.h` |
| Go       | `.go`      |
| Zig      | `.zig`     |

## Usage

Build the executable:

```sh
zig build
```

Count one file:

```sh
zig build run -- path/to/file.zig
```

Example output:

```text
blank:   4
comment: 2
code:    19
```

Print line-by-line classifications for debugging:

```sh
zig build run -- --debug-lines path/to/file.go
```

## Development

Run tests:

```sh
zig build test
```

The main implementation is split across:

- `src/root.zig`: public API and CLI entry point
- `src/languages.zig`: language metadata and extension detection
- `src/syntax.zig`: lexer rule definitions
- `src/lexer.zig`: generic syntax-driven lexer

## Roadmap

- [x] Accept one file path from CLI arguments.
- [x] Detect language from the file extension.
- [x] Count blank lines, comment lines, and code lines.
- [x] Support C, Go, and Zig.
- [x] Add debug output for line classification.
- [ ] Accept multiple file paths.
- [ ] Aggregate totals by language.
- [ ] Print table output with a total row.
- [ ] Walk directories recursively.
- [ ] Ignore common generated and dependency directories.
- [ ] Add more languages.
- [ ] Add `.gitignore` awareness.

## License

MIT. See [LICENSE](LICENSE).
