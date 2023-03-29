const std = @import("std");

pub fn isValidIsbn10(s: []const u8) bool {
    var digits: [10]u8 = undefined;
    var index: usize = 0;

    for (s) |char| {
        if (index >= 10) {
            return false;
        } else if (char == 'X' and index == 9) {
            digits[index] = 10;
            index += 1;
        } else if (std.ascii.isDigit(char)) {
            digits[index] = std.fmt.charToDigit(char, 10) catch unreachable;
            index += 1;
        } else if (char != '-') {
            return false;
        }
    }

    if (index != 10) {
        return false;
    }

    var sum: usize = 0;
    for (digits) |digit, i| {
        sum += digit * (10 - i);
    }

    return sum % 11 == 0;
}
