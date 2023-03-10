// Import the appropriate standard library and modules
const mem = @import("std").mem;

pub const RnaError = error{
    UnknownDna,
};

pub fn toRna(allocator: mem.Allocator, dna: []const u8) (RnaError || mem.Allocator.Error)![]const u8 {
    var rna = try allocator.alloc(u8, dna.len);

    for (dna) |e, i| {
        rna[i] = switch (e) {
            'G' => 'C',
            'C' => 'G',
            'T' => 'A',
            'A' => 'U',
            else => return error.UnknownDna,
        };
    }
    return rna;
}
