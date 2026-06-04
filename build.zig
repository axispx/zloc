const std = @import("std");

const version = "0.1.1";

pub fn build(b: *std.Build) void {
    const target = b.standardTargetOptions(.{});
    const optimize = b.standardOptimizeOption(.{});

    const options = b.addOptions();
    options.addOption([]const u8, "version", version);
    const build_options_mod = options.createModule();

    // build
    const zloc_mod = b.createModule(.{
        .root_source_file = b.path("src/root.zig"),
        .target = target,
        .optimize = optimize,
        .imports = &.{
            .{ .name = "build_options", .module = build_options_mod },
        },
    });

    const exe = b.addExecutable(.{
        .name = "zloc",
        .root_module = b.createModule(.{
            .root_source_file = b.path("src/main.zig"),
            .target = target,
            .optimize = optimize,
            .imports = &.{
                .{ .name = "zloc", .module = zloc_mod },
            },
        }),
    });
    b.installArtifact(exe);

    // run
    const run_cmd = b.addRunArtifact(exe);
    const run_step = b.step("run", "Run the app");
    run_step.dependOn(&run_cmd.step);

    if (b.args) |args| {
        run_cmd.addArgs(args);
    }

    // test
    const root_tests = b.addTest(.{
        .root_module = zloc_mod,
    });
    const run_root_tests = b.addRunArtifact(root_tests);
    const test_step = b.step("test", "Run tests");
    test_step.dependOn(&run_root_tests.step);
}
