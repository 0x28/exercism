const std = @import("std");
const time = std.time;
const DefaultPrng = std.rand.DefaultPrng;
const sort = std.sort;

pub fn modifier(score: i8) i8 {
    return @divFloor(score - 10, 2);
}

pub fn ability() i8 {
    var rng = DefaultPrng.init(@intCast(u64, time.milliTimestamp()));
    var rolls: [4]i8 = undefined;

    for (rolls) |*roll| {
        roll.* = rng.random().intRangeLessThan(i8, 1, 7);
    }

    sort.sort(i8, &rolls, {}, comptime sort.desc(i8));

    return rolls[0] + rolls[1] + rolls[2];
}

pub const Character = struct {
    strength: i8,
    dexterity: i8,
    constitution: i8,
    intelligence: i8,
    wisdom: i8,
    charisma: i8,
    hitpoints: i8,

    pub fn init() Character {
        const constitution = ability();
        var char = .{
            .strength = ability(),
            .dexterity = ability(),
            .constitution = constitution,
            .intelligence = ability(),
            .wisdom = ability(),
            .charisma = ability(),
            .hitpoints = 10 + modifier(constitution),
        };

        return char;
    }
};
