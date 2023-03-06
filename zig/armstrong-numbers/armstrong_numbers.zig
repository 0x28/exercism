const std = @import("std");

pub fn isArmstrongNumber(num: u128) bool {
    var rest = num;
    var sum: u129 = 0;

    if (num == 0) {
        return true;
    }

    const digits = @floatToInt(u128, @log10(@intToFloat(f64, num))) + 1;

    while (rest > 0) : (rest /= 10) {
        sum += std.math.pow(u128, rest % 10, digits);
    }

    return sum == num;
}
