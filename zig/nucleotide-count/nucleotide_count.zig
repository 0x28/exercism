pub const NucleotideError = error{Invalid};

const ascii = @import("std").ascii;
pub const Counts = struct {
    a: u32 = 0,
    c: u32 = 0,
    g: u32 = 0,
    t: u32 = 0,
};

pub fn countNucleotides(s: []const u8) NucleotideError!Counts {
    var count = Counts{};
    for (s) |char| {
        switch (ascii.toLower(char)) {
            'a' => count.a += 1,
            'c' => count.c += 1,
            'g' => count.g += 1,
            't' => count.t += 1,
            else => return NucleotideError.Invalid,
        }
    }

    return count;
}
