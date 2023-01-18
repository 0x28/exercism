type OldSystem = {[key: number]: string[]}
type NewSystem = {[key: string]: number}

export function transform(old: OldSystem): NewSystem {
    let result: NewSystem = {}

    for(let key in old) {
        for (let char of old[key]) {
            result[char.toLowerCase()] = Number(key)
        }
    }

    return result
}
