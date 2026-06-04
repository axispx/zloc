const std = @import("std");
const zloc = @import("zloc");

pub fn main(init: std.process.Init) !void {
    const arena = init.arena.allocator();
    const args = try init.minimal.args.toSlice(arena);

    try zloc.run(init.io, arena, args);
}
