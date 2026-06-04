/// Example: `// comment`
pub const LineCommentRule = struct {
    marker: []const u8,
};

/// Example: `/* comment */`
pub const BlockCommentRule = struct {
    start: []const u8,
    end: []const u8,
    nested: bool = false,
};

/// Examples: `"text"`, `'c'`, or `` `template` ``
pub const QuotedRule = struct {
    start: []const u8,
    end: []const u8,
    escape: ?u8 = null,
    multiline: bool = false,
};

/// Example: Zig `\\text`
pub const LineStringRule = struct {
    marker: []const u8,
};

/// SyntaxSpec tells the lexer what syntax a language uses.
pub const SyntaxSpec = struct {
    /// Comments that start at a marker and continue to the end of the line.
    line_comments: []const LineCommentRule = &.{},

    /// Comments that start and end with markers, and can span many lines.
    block_comments: []const BlockCommentRule = &.{},

    /// Strings/chars/templates where comment markers should be ignored.
    quoted: []const QuotedRule = &.{},

    /// Strings that start at a marker and continue to the end of the line.
    line_strings: []const LineStringRule = &.{},
};
