pub const ColorBand = enum { black, brown, red, orange, yellow, green, blue, violet, grey, white };

pub fn colorCode(color: ColorBand) isize {
    return @enumToInt(color);
}

pub fn colors() []const ColorBand {
    comptime {
        var allColors: [@typeInfo(ColorBand).Enum.fields.len]ColorBand = undefined;
        for (&allColors) |*color, i| {
            color.* = @intToEnum(ColorBand, i);
        }

        return &allColors;
    }
}
