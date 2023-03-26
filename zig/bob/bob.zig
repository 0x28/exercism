const std = @import("std");

pub fn response(s: []const u8) []const u8 {
    const question = isQuestion(s);

    if (isSilent(s)) {
        return "Fine. Be that way!";
    } else if (isShouting(s)) {
        if (question) {
            return "Calm down, I know what I'm doing!";
        } else {
            return "Whoa, chill out!";
        }
    } else if (question) {
        return "Sure.";
    }

    return "Whatever.";
}

fn isQuestion(s: []const u8) bool {
    var question = false;
    for (s) |char| {
        if (std.ascii.isAlpha(char)) {
            question = false;
        } else if (char == '?') {
            question = true;
        }
    }

    return question;
}

fn isShouting(s: []const u8) bool {
    var shouting = false;
    for (s) |char| {
        if (std.ascii.isUpper(char)) {
            shouting = true;
        } else if (std.ascii.isLower(char)) {
            return false;
        }
    }

    return shouting;
}

fn isSilent(array: []const u8) bool {
    for (array) |element| {
        if (!std.ascii.isWhitespace(element)) {
            return false;
        }
    }

    return true;
}
