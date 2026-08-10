# Changelog

All notable changes to `zloc` will be documented in this file.

## 0.2.0 - 2026-08-10

### Added

- Support Gleam (`.gleam`).
- Counting tests for Elixir, Erlang, and Gleam.

## 0.1.1 - 2026-06-04

### Added

- `build.zig.zon` package manifest.

## 0.1.0 - 2026-06-04

### Added

- Initial public release.
- Count blank, comment, and code lines.
- Support counting multiple files and directories.
- Recursively walk non-Git directories.
- Use `git ls-files` for Git repositories so ignored files are filtered automatically.
- Detect languages from exact filenames and file extensions.
- Support 60+ languages.
- Support syntax-aware counting with line comments, block comments, quoted strings, line strings, and nested block comments.
- Print aggregated totals by language.
- Sort summary output by code lines.
- Print human-readable numbers with commas.
- Add debug output for line-by-line classifications.
- Add verbose output for unsupported files and traversal details.
- Add development documentation for build, testing, language support, lexer tests, and release steps.
