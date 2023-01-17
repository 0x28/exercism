enum Color {
    black = 0,
    brown = 1,
    red = 2,
    orange = 3,
    yellow = 4,
    green = 5,
    blue = 6,
    violet = 7,
    grey = 8,
    white = 9,
}

type ColorName = keyof typeof Color
type ColorNames = [ColorName, ColorName, ...ColorName[]] // length >= 2

export function decodedValue(colors: ColorNames): number {
    return Color[colors[0]] * 10 + Color[colors[1]]
}
