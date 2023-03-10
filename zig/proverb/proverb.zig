const mem = @import("std").mem;
const fmt = @import("std").fmt;

pub fn recite(allocator: mem.Allocator, words: []const []const u8) (fmt.AllocPrintError || mem.Allocator.Error)![][]u8 {
    var proverb = try allocator.alloc([]u8, words.len);
    var idx: usize = 0;

    while (idx < words.len) : (idx += 1) {
        proverb[idx] = try if (idx == words.len - 1)
            fmt.allocPrint(
                allocator,
                "And all for the want of a {s}.\n",
                .{words[0]},
            )
        else
            fmt.allocPrint(
                allocator,
                "For want of a {s} the {s} was lost.\n",
                .{ words[idx], words[idx + 1] },
            );
    }

    return proverb;
}
