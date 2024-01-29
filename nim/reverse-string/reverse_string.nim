proc reverse*(s: string): string =
  var reversed = ""

  for i in 0 ..< s.len:
    reversed.add(s[s.len - i - 1])

  return reversed
