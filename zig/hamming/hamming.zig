pub const DnaError = error{
    EmptyDnaStrands,
    UnequalDnaStrands,
};

pub fn compute(first: []const u8, second: []const u8) DnaError!usize {
    var diff: usize = 0;

    if (first.len == 0 or second.len == 0) {
        return DnaError.EmptyDnaStrands;
    } else if (first.len != second.len) {
        return DnaError.UnequalDnaStrands;
    }

    for (first) |elem, idx| {
        if (elem != second[idx]) {
            diff += 1;
        }
    }

    return diff;
}
