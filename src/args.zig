const std = @import("std");

pub const Options = struct {
    debug: bool = false,
    verbose: bool = false,
    paths: []const [:0]const u8,
};

pub const ParseResult = union(enum) {
    options: Options,
    version,
    missing_paths,
    unknown_option: []const u8,
};

pub fn parse(raw_args: []const [:0]const u8) ParseResult {
    if (raw_args.len < 2) {
        return .missing_paths;
    }

    var options = Options{
        .paths = &.{},
    };

    var path_index: usize = 1;
    while (path_index < raw_args.len and std.mem.startsWith(u8, raw_args[path_index], "--")) {
        if (std.mem.eql(u8, raw_args[path_index], "--version")) {
            return .version;
        } else if (std.mem.eql(u8, raw_args[path_index], "--debug")) {
            options.debug = true;
        } else if (std.mem.eql(u8, raw_args[path_index], "--verbose")) {
            options.verbose = true;
        } else {
            return .{ .unknown_option = raw_args[path_index] };
        }

        path_index += 1;
    }

    if (path_index == raw_args.len) {
        return .missing_paths;
    }

    options.paths = raw_args[path_index..];
    return .{ .options = options };
}

pub fn printUsage(program_name: []const u8) void {
    std.debug.print("usage: {s} [--debug] [--verbose] [--version] <file-or-directory>...\n", .{program_name});
}

test "parses paths without flags" {
    const raw_args = [_][:0]const u8{
        "zloc",
        "src",
        "build.zig",
    };

    const options = switch (parse(&raw_args)) {
        .options => |options| options,
        else => return error.UnexpectedParseFailure,
    };

    try std.testing.expect(!options.debug);
    try std.testing.expect(!options.verbose);
    try std.testing.expectEqual(@as(usize, 2), options.paths.len);
    try std.testing.expectEqualStrings("src", options.paths[0]);
    try std.testing.expectEqualStrings("build.zig", options.paths[1]);
}

test "parses debug and verbose flags" {
    const raw_args = [_][:0]const u8{
        "zloc",
        "--debug",
        "--verbose",
        "src",
    };

    const options = switch (parse(&raw_args)) {
        .options => |options| options,
        else => return error.UnexpectedParseFailure,
    };

    try std.testing.expect(options.debug);
    try std.testing.expect(options.verbose);
    try std.testing.expectEqual(@as(usize, 1), options.paths.len);
    try std.testing.expectEqualStrings("src", options.paths[0]);
}

test "requires at least one path" {
    const raw_args = [_][:0]const u8{
        "zloc",
        "--debug",
    };

    try std.testing.expectEqual(ParseResult.missing_paths, parse(&raw_args));
}

test "parses version flag" {
    const raw_args = [_][:0]const u8{
        "zloc",
        "--version",
    };

    try std.testing.expectEqual(ParseResult.version, parse(&raw_args));
}

test "rejects unknown flags" {
    const raw_args = [_][:0]const u8{
        "zloc",
        "--wat",
        "src",
    };

    switch (parse(&raw_args)) {
        .unknown_option => |option| try std.testing.expectEqualStrings("--wat", option),
        else => return error.UnexpectedParseFailure,
    }
}
