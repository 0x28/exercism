class Forth
  alias Value = String | Int32

  def self.evaluate(str)
    stack = [] of Int32
    tokens = tokenize(str)
    env = Hash(String, Array(Value)).new

    eval_user_defined(env, tokens, stack)

    stack
  end

  private def self.eval_user_defined(env, tokens, stack)
    idx = 0

    while idx < tokens.size
      token = tokens[idx]

      if token.is_a?(Int32)
        stack.push(token)
      elsif token == ":"
        idx = add_definition(env, idx + 1, tokens)
      elsif token.is_a?(String)
        if env.has_key?(token)
          eval_user_defined(env, env[token], stack)
        else
          eval_buitin(token, stack)
        end
      end

      idx += 1
    end
  end

  private def self.add_definition(env, idx, tokens)
    name = tokens[idx]
    idx += 1
    definition = [] of Value

    while idx < tokens.size && tokens[idx] != ";"
      if env.has_key?(tokens[idx])
        definition.concat(env[tokens[idx]]) # resolve during definition
      else
        definition.push(tokens[idx])
      end

      idx += 1
    end

    if name.is_a?(String)
      env[name] = definition
    else
      raise ArgumentError.new
    end

    idx
  end

  private def self.eval_buitin(str, stack)
    case str
    when "+" then ensure_size(stack, 2) { stack.push(stack.pop + stack.pop) }
    when "-" then ensure_size(stack, 2) {
                   right, left = stack.pop, stack.pop
                   stack.push(left - right)
                 }
    when "*" then ensure_size(stack, 2) { stack.push(stack.pop * stack.pop) }
    when "/" then ensure_size(stack, 2) {
                   right, left = stack.pop, stack.pop
                   raise ArgumentError.new if right.zero?
                   stack.push(left // right)
                 }
    when "dup" then ensure_size(stack, 1) { stack.push(stack.last) }
    when "drop" then ensure_size(stack, 1) { stack.pop }
    when "swap" then ensure_size(stack, 2) { stack[-1], stack[-2] = stack[-2], stack[-1] }
    when "over" then ensure_size(stack, 2) { stack.push(stack[-2]) }
    else raise ArgumentError.new
    end
  end

  private def self.ensure_size(stack, expected_size, &)
    raise ArgumentError.new if stack.size < expected_size
    yield
  end

  private def self.tokenize(str)
    str.downcase.scan(/(\-?[0-9]+|[:;*\/+-]|[a-z-_]+)/).map { |token|
      number = token[0].to_i?
      if number
        number
      else
        token[0]
      end
    }
  end
end
