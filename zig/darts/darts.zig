pub const Coordinate = struct {
    x: f32,
    y: f32,

    pub fn init(x_coord: f32, y_coord: f32) Coordinate {
        return Coordinate{ .x = x_coord, .y = y_coord };
    }

    pub fn score(self: Coordinate) usize {
        var dist = @sqrt(self.x * self.x + self.y * self.y);

        if (dist <= 1) {
            return 10;
        } else if (dist <= 5) {
            return 5;
        } else if (dist <= 10) {
            return 1;
        } else {
            return 0;
        }
    }
};
