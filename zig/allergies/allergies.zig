const std = @import("std");
const EnumSet = std.EnumSet;

pub const Allergen = enum {
    eggs,
    peanuts,
    shellfish,
    strawberries,
    tomatoes,
    chocolate,
    pollen,
    cats,
};

pub fn isAllergicTo(score: u8, allergen: Allergen) bool {
    return initAllergenSet(score).contains(allergen);
}

pub fn initAllergenSet(score: usize) EnumSet(Allergen) {
    const bitset: std.bit_set.IntegerBitSet(8) = .{ .mask = @truncate(u8, score) };
    const init: EnumSet(Allergen) = .{ .bits = bitset };

    return init;
}
