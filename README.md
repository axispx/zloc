# zloc

`zloc` is a small, blazingly fast ⚡ source code line counter written in Zig.

## Status

`zloc` counts one or more file or directory paths recursively. It detects the language from each file extension, runs a lightweight lexer for that language, and prints line counts.

For directory inputs inside a Git repository, `zloc` uses `git ls-files` so files are automatically filtered using `.gitignore`. Non-Git directories fall back to recursive filesystem traversal.

## Supported Languages

`zloc` supports 60+ languages. See the full list [here](src/languages.zig#L4).

## Install

Requires Zig.

### From Source

#### macOS and Linux

Install `zloc` to `~/.local/bin`:

```sh
zig build -Doptimize=ReleaseFast --prefix ~/.local
```

Make sure `~/.local/bin` is in your `PATH`:

```sh
echo 'export PATH="$HOME/.local/bin:$PATH"' >> ~/.zshrc
source ~/.zshrc
```

#### Windows

Build the release executable:

```powershell
zig build -Doptimize=ReleaseFast
```

Then run it from the build output:

```powershell
.\zig-out\bin\zloc.exe path\to\source
```

To use `zloc` from any terminal, add the `zig-out\bin` directory or a copied `zloc.exe` location to your `PATH`.

## Usage

Count one or more files or directories:

```sh
zloc src path/to/file.go
```

Example output:

```text
------------------------------------------------------------
Language                    Files    Blank    Comment    Code
------------------------------------------------------------
Zig                             1        2          1       6
Go                              1        2          5       6
------------------------------------------------------------
Total                           2        4          6      12
------------------------------------------------------------
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

For build commands, project structure, language rules, and release steps, see [DEVELOPMENT.md](DEVELOPMENT.md).

To add a language, start with the [Adding Language Support](DEVELOPMENT.md#adding-language-support) section.

## License

MIT. See [LICENSE](LICENSE).
