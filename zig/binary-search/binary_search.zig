pub const SearchError = error{
    ValueAbsent,
    EmptyBuffer,
};

pub fn binarySearch(comptime T: type, target: usize, buffer: ?[]const T) SearchError!usize {
    var buf = buffer orelse return error.EmptyBuffer;

    if (buf.len == 0) {
        return error.EmptyBuffer;
    }

    var high: usize = buf.len - 1;
    var low: usize = 0;

    while (true) {
        var mid: usize = (high + low) / 2;
        if (target == buf[mid]) {
            return mid;
        } else if (high == low) {
            return error.ValueAbsent;
        } else if (target < buf[mid]) {
            high = mid - 1;
        } else {
            low = mid + 1;
        }
    }
}
