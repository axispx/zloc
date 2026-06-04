const std = @import("std");
const cli_args = @import("args.zig");
const languages = @import("languages.zig");
const lexer = @import("lexer.zig");
const report = @import("report.zig");
const walker = @import("walker.zig");

pub const Language = languages.Language;
pub const Counts = lexer.Counts;
pub const CountOptions = lexer.CountOptions;

pub fn countText(language: Language, text: []const u8) Counts {
    return countTextOptions(language, text, .{});
}

pub fn countTextOptions(language: Language, text: []const u8, options: CountOptions) Counts {
    const spec = languages.syntaxFor(language);
    return lexer.countWithSyntaxOptions(spec, text, options);
}

pub fn run(io: std.Io, allocator: std.mem.Allocator, args: []const [:0]const u8) !void {
    const options = switch (cli_args.parse(args)) {
        .options => |options| options,
        .missing_paths => {
            cli_args.printUsage(args[0]);
            return;
        },
        .unknown_option => |option| {
            std.debug.print("unknown option: {s}\n", .{option});
            cli_args.printUsage(args[0]);
            return;
        },
    };

    var buffer: [64 * 1024]u8 = undefined;
    var summaries = report.initSummaries();

    var context = walker.Context{
        .allocator = allocator,
        .io = io,
        .debug = options.debug,
        .verbose = options.verbose,
        .summaries = &summaries,
        .buffer = &buffer,
    };

    for (options.paths) |path| {
        try walker.countPath(&context, path);
    }

    report.printSummaryTable(&summaries);
}
