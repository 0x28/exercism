const std = @import("std");
const mem = std.mem;

pub const Signal = enum(isize) {
    wink = 0b00001,
    double_blink = 0b00010,
    close_your_eyes = 0b00100,
    jump = 0b01000,
    reverse = 0b10000,
};
const SignalValues = std.enums.values(Signal);

pub fn calculateHandshake(allocator: mem.Allocator, number: isize) mem.Allocator.Error![]const Signal {
    var signals = try allocator.alloc(Signal, SignalValues.len - 1);
    var idx: usize = 0;

    inline for (SignalValues) |value| {
        if (@enumToInt(value) & number > 0) {
            if (value == Signal.reverse) {
                std.mem.reverse(Signal, signals[0..idx]);
            } else {
                signals[idx] = value;
                idx += 1;
            }
        }
    }

    signals = try allocator.realloc(signals, idx);

    return signals;
}
