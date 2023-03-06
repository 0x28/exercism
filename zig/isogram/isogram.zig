const std = @import("std");

pub fn isIsogram(str: []const u8) bool {
    var seen: u26 = 0;

    for (str) |char| {
        if (std.ascii.isAlphabetic(char)) {
            const pos = std.math.shl(u26, 1, std.ascii.toLower(char) - 'a');
            if (seen & pos != 0) {
                return false;
            }
            seen |= pos;
        }
    }

    return true;
}
