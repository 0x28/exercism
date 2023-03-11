pub fn primes(buffer: []u32, comptime limit: u32) []u32 {
    var sieve = [_]u32{0} ** limit;
    var bufferIdx: usize = 0;

    for (sieve) |_, i| {
        sieve[i] = @intCast(u32, i + 2);
    }

    var primeIdx: usize = 0;
    while (primeIdx < sieve.len and sieve[primeIdx] <= limit) {
        buffer[bufferIdx] = sieve[primeIdx];
        bufferIdx += 1;

        var filterIdx: usize = primeIdx + sieve[primeIdx];

        while (filterIdx < sieve.len) : (filterIdx += sieve[primeIdx]) {
            sieve[filterIdx] = 0;
        }

        primeIdx += 1;
        while (primeIdx < sieve.len and sieve[primeIdx] == 0) {
            primeIdx += 1;
        }
    }

    return buffer[0..bufferIdx];
}
