class Matrix
  @data : Array(Array(Int32))

  def initialize(input)
    @data = input.split('\n').map { |line|
      line.split(' ').map(&.to_i32)
    }
  end

  def row(idx)
    @data[idx - 1]
  end

  def column(idx)
    @data.map { |row| row[idx - 1] }
  end
end
