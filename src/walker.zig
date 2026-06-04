const std = @import("std");
const languages = @import("languages.zig");
const report = @import("report.zig");
const lexer = @import("lexer.zig");

pub const Context = struct {
    io: std.Io,
    debug: bool,
    summaries: *report.SummarySet,
    buffer: *[64 * 1024]u8,
};

pub fn countPath(context: *Context, path: []const u8) !void {
    const cwd = std.Io.Dir.cwd();

    const stat = cwd.statFile(context.io, path, .{}) catch |err| switch (err) {
        error.FileNotFound => {
            std.debug.print("path not found: {s}\n", .{path});
            return;
        },
        else => return err,
    };

    switch (stat.kind) {
        .file => try countFile(context, path),
        .directory => try countDirectory(context, path),
        else => {
            std.debug.print("unsupported path type: {s}\n", .{path});
        },
    }
}

fn countFile(context: *Context, path: []const u8) !void {
    const language = languages.detect(path) orelse {
        std.debug.print("unsupported file type: {s}\n", .{path});
        return;
    };

    const text = try std.Io.Dir.cwd().readFile(context.io, path, context.buffer);

    if (context.debug) {
        std.debug.print("{s}:\n", .{path});
    }

    const spec = languages.syntaxFor(language);
    const counts = lexer.countWithSyntaxOptions(spec, text, .{
        .debug = context.debug,
    });

    report.addFile(context.summaries, language, counts);
}

fn countDirectory(context: *Context, path: []const u8) !void {
    var dir = try std.Io.Dir.cwd().openDir(context.io, path, .{
        .iterate = true,
    });
    defer dir.close(context.io);

    var iterator = dir.iterate();
    while (try iterator.next(context.io)) |entry| {
        var child_path_buffer: [std.fs.max_path_bytes]u8 = undefined;
        const child_path = try std.fmt.bufPrint(
            &child_path_buffer,
            "{s}/{s}",
            .{ path, entry.name },
        );

        switch (entry.kind) {
            .file => try countFile(context, child_path),
            .directory => try countDirectory(context, child_path),
            else => {},
        }
    }
}
