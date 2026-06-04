pub const LineCommentRule = struct {
    marker: []const u8,
};

pub const BlockCommentRule = struct {
    start: []const u8,
    end: []const u8,
    nested: bool = false,
};

pub const QuotedRule = struct {
    start: []const u8,
    end: []const u8,
    escape: ?u8 = null,
    multiline: bool = false,
};

pub const LineStringRule = struct {
    marker: []const u8,
};

pub const SyntaxSpec = struct {
    line_comments: []const LineCommentRule = &.{},
    block_comments: []const BlockCommentRule = &.{},
    quoted: []const QuotedRule = &.{},
    line_strings: []const LineStringRule = &.{},
};
