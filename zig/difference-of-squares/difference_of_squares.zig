pub fn squareOfSum(number: usize) usize {
    var sum = number * (number + 1) / 2;
    return sum * sum;
}

pub fn sumOfSquares(number: usize) usize {
    var sum: usize = 0;
    var i: usize = 1;

    while (i <= number) {
        sum += i * i;
        i += 1;
    }

    return sum;
}

pub fn differenceOfSquares(number: usize) usize {
    return squareOfSum(number) - sumOfSquares(number);
}
