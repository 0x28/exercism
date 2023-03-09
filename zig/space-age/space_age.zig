pub const Planet = enum {
    mercury,
    venus,
    earth,
    mars,
    jupiter,
    saturn,
    uranus,
    neptune,

    pub fn age(self: Planet, seconds: usize) f64 {
        var years: f64 = @intToFloat(f64, seconds) / 31557600.0;

        return years / self.factor();
    }

    fn factor(self: Planet) f64 {
        switch (self) {
            Planet.mercury => return 0.2408467,
            Planet.venus => return 0.61519726,
            Planet.earth => return 1.0,
            Planet.mars => return 1.8808158,
            Planet.jupiter => return 11.862615,
            Planet.saturn => return 29.447498,
            Planet.uranus => return 84.016846,
            Planet.neptune => return 164.79132,
        }
    }
};
