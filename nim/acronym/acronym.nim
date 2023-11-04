import strutils

proc abbreviate*(s: string): string =
  var words = s.split({'-', ' ', '_'})
  var acronym = ""

  for word in words:
    if word.len > 0:
       acronym &= word[0].toUpperAscii

  acronym
