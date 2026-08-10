const std = @import("std");
const languages = @import("languages.zig");
const report = @import("report.zig");
const lexer = @import("lexer.zig");

pub const Context = struct {
    allocator: std.mem.Allocator,
    io: std.Io,
    debug: bool,
    verbose: bool,
    summaries: *report.SummarySet,
    buffer: *[64 * 1024]u8,
};

const GitListResult = enum {
    used_git,
    not_git,
};

pub fn countPath(context: *Context, path: []const u8) !void {
    const cwd = std.Io.Dir.cwd();

    const stat = cwd.statFile(context.io, path, .{}) catch |err| switch (err) {
        error.FileNotFound => {
            if (context.verbose) {
                std.debug.print("path not found: {s}\n", .{path});
            }
            return;
        },
        else => return err,
    };

    switch (stat.kind) {
        .file => try countFile(context, path),
        .directory => try countDirectory(context, path),
        else => {
            if (context.verbose) {
                std.debug.print("unsupported path type: {s}\n", .{path});
            }
        },
    }
}

fn countFile(context: *Context, path: []const u8) !void {
    const language = languages.detect(path) orelse {
        if (context.verbose) {
            std.debug.print("unsupported file type: {s}\n", .{path});
        }
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
    switch (try countGitDirectory(context, path)) {
        .used_git => return,
        .not_git => {},
    }

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

fn countGitDirectory(context: *Context, path: []const u8) !GitListResult {
    // Include tracked and untracked files, but still honor .gitignore.
    // Repos with no commits yet only have untracked files.
    const result = std.process.run(context.allocator, context.io, .{
        .argv = &.{ "git", "-C", path, "ls-files", "-z", "--cached", "--others", "--exclude-standard" },
        .stdout_limit = .limited(32 * 1024 * 1024),
        .stderr_limit = .limited(1024 * 1024),
    }) catch |err| switch (err) {
        error.FileNotFound => return .not_git,
        else => return err,
    };
    defer context.allocator.free(result.stdout);
    defer context.allocator.free(result.stderr);

    switch (result.term) {
        .exited => |code| {
            if (code != 0) {
                return .not_git;
            }
        },
        else => return .not_git,
    }

    if (context.verbose) {
        std.debug.print("using git ls-files: {s}\n", .{path});
    }

    var files = std.mem.splitScalar(u8, result.stdout, 0);
    while (files.next()) |file| {
        if (file.len == 0) {
            continue;
        }

        var file_path_buffer: [std.fs.max_path_bytes]u8 = undefined;
        const file_path = try std.fmt.bufPrint(
            &file_path_buffer,
            "{s}/{s}",
            .{ path, file },
        );

        try countFile(context, file_path);
    }

    return .used_git;
}
