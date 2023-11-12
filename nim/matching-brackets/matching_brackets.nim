proc isPaired*(s: string): bool =
  var stack: seq[char] = @[]
  for c in s:
    case c:
      of '{':
        stack.add('}')
      of '(':
        stack.add(')')
      of '[':
        stack.add(']')
      of ']', ')', '}':
        if stack.len() == 0 or stack.pop() != c:
          return false
      else:
        continue

  return stack.len() == 0
