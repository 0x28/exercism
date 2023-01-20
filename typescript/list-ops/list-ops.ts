export class List<T> {
    public static create<T = any>(...values: T[]): List<T> {
        let list: List<T> = new List()

        for(var i = values.length - 1; i >= 0; --i) {
            list = new List(values[i], list)
        }

        return list
    }

    public forEach(fun: (arg: unknown) => unknown) {
        this.foldl<unknown, void>((_, e) => fun(e), null)
    }

    public append(other: List<T>): List<T> {
        return this.foldr<List<T>, unknown>((acc, e) => {
            return new List(e, acc)
        }, other)
    }

    public concat(lists: List<List<T>>): List<T> {
        return lists.foldl<List<T>, List<T>>((acc, e) => {
            return acc.append(e)
        }, this)
    }

    public foldr<A, E>(fun: (acc: A, e: E) => A, zero: A): A {
        if(this.values === undefined) {
            return zero
        } else {
            return fun(this.values.tail.foldr(fun, zero), this.values.head as E)
        }
    }

    public foldl<A, E>(fun: (acc: A, elem: E) => A, zero: A): A {
        if(this.values === undefined) {
            return zero
        } else {
            let value = fun(zero, this.values.head as E)
            return this.values.tail.foldl(fun, value)
        }
    }

    public reverse(): List<T> {
        return this.foldl<List<T>, unknown>((acc, e) => {
            return new List(e, acc)
        }, new List())
    }

    public map<U>(fun: (arg: T) => U): List<U> {
        return this.foldr<List<U>, T>((acc, e) => {
            return new List(fun(e), acc)
        }, new List())
    }

    public filter<T>(pred: (arg: T) => boolean): List<T> {
        return this.foldr<List<T>, unknown>((acc, e) => {
            if (pred(e as T)) {
                return new List(e, acc)
            } else {
                return acc
            }
        }, new List())
    }


    public length(): number {
        return this.foldl<number, unknown>((count, _) => {
            return count + 1
        }, 0)
    }

    constructor(head?: unknown, tail?: List<T>) {
        if (head && tail) {
            this.values = {head, tail}
        }
    }

    values?: { head: unknown, tail: List<T> } = undefined;
}
