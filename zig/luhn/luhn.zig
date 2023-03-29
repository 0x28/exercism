pub fn isValid(s: []const u8) bool {
    var sum: usize = 0;
    var num_digits: usize = 0;

    if (s.len <= 1) {
        return false;
    }

    var idx = s.len - 1;

    while (true) {
        const char = s[idx];
        switch (char) {
            '0'...'9' => {
                var digit = char - '0';
                num_digits += 1;
                if (num_digits % 2 == 0) {
                    digit *= 2;
                    if (digit > 9) {
                        digit -= 9;
                    }
                }
                sum += digit;
            },
            ' ' => {},
            else => return false,
        }

        if (idx == 0) {
            break;
        }
        idx -= 1;
    }

    return num_digits > 1 and sum % 10 == 0;
}
