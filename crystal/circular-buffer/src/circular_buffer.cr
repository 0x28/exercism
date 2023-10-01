class CircularBuffer
  def initialize(size)
    @buffer = Array(Int32).new(size) { 0 }
    @read_pos = 0
    @count = 0
  end

  def read()
    if @count == 0
      raise RuntimeError.new("Circular buffer is empty")
    end

    old_pos = @read_pos
    @read_pos = (@read_pos + 1) % @buffer.size
    @count -= 1
    @buffer[old_pos]
  end

  def clear()
    @read_pos = 0
    @count = 0
  end

  def write(value : Int32)
    if @count == @buffer.size
      raise RuntimeError.new("Circular buffer is full")
    end

    write_pos = (@read_pos + @count) % @buffer.size
    @buffer[write_pos] = value
    @count += 1
  end

  def overwrite(value : Int32)
    if @count == @buffer.size
      read()
    end

    write(value)
  end
end
