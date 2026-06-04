# zloc

`zloc` is a small `cloc`-style command line tool written in Zig. It counts blank lines, comment lines, and code lines for source files.

## Status

`zloc` currently counts one or more file paths. It detects the language from each file extension, runs a lightweight lexer for that language, and prints line counts.

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

Count one or more files:

```sh
zig build run -- path/to/file.zig path/to/file.go
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

- [x] Accept one or more file paths from CLI arguments.
- [x] Detect language from the file extension.
- [x] Count blank lines, comment lines, and code lines.
- [x] Support C, Go, and Zig.
- [x] Add debug output for line classification.
- [x] Accept multiple file paths.
- [x] Aggregate totals by language.
- [x] Print table output with a total row.
- [ ] Walk directories recursively.
- [ ] Ignore common generated and dependency directories.
- [ ] Add more languages.
- [ ] Add `.gitignore` awareness.

## License

MIT. See [LICENSE](LICENSE).
