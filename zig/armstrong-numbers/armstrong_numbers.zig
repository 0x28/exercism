const std = @import("std");

pub fn isArmstrongNumber(num: u128) bool {
    var rest = num;
    var sum: u128 = 0;

    if (num == 0) {
        return true;
    }

    const digits = @floatToInt(u128, @ceil(@log10(@intToFloat(f64, num))));

    while (rest > 0) : (rest /= 10) {
        sum += std.math.pow(u128, rest % 10, digits);
    }

    return sum == num;
}
