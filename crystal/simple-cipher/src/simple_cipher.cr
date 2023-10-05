class SimpleCipher
  getter key : String

  def initialize(@key)
  end

  def initialize()
    random = Random.new
    @key = (0..50).map { |e| 'a' + random.rand(26) }.join
  end

  def encode(text : String)
    zip_with_key(text).map { |c, k| shift(c, k, &.+) }.join
  end

  def decode(text : String)
    zip_with_key(text).map { |c, k| shift(c, k, &.-) }.join
  end

  private def zip_with_key(text : String)
    text.each_char.zip(key.each_char.cycle)
  end

  private def shift(input : Char, key : Char, &operation) : Char
    'a' + (input - 'a' + yield key - 'a') % 26
  end
end
