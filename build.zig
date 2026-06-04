const std = @import("std");

pub fn build(b: *std.Build) void {
    const target = b.standardTargetOptions(.{});
    const optimize = b.standardOptimizeOption(.{});

    // build
    const zloc_mod = b.createModule(.{
        .root_source_file = b.path("src/root.zig"),
        .target = target,
        .optimize = optimize,
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
