import strutils

proc isPangram*(s: string): bool =
  var letters: set[char] = {'a' .. 'z'}

  for ch in s:
    excl(letters, toLowerAscii(ch))

  letters == {}
