export function accumulate<A, B>(list: A[], accumulator: (arg: A) => B): B[] {
    let mapped: B[] = []

    for(let elem of list) {
        mapped.push(accumulator(elem))
    }

    return mapped
}
