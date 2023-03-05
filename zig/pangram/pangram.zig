const std = @import("std");

pub fn isPangram(str: []const u8) bool {
    var seen: u26 = 0;

    for (str) |char| {
        if (std.ascii.isAlphabetic(char)) {
            seen |= std.math.shl(u26, 1, std.ascii.toLower(char) - 'a');
        }
    }

    return seen == 0x3FFFFFF;
}
