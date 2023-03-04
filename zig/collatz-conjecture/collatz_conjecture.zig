pub const ComputationError = error{
    IllegalArgument,
};

pub fn steps(number: usize) anyerror!usize {
    var step: usize = 0;
    var num: usize = number;

    if (num == 0) {
        return ComputationError.IllegalArgument;
    }

    while (num != 1) : (step += 1) {
        if (num % 2 == 0) {
            num /= 2;
        } else {
            num = num * 3 + 1;
        }
    }

    return step;
}
