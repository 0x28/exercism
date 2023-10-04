class Node(T)
  getter value : T
  getter left : Nil | Node(T)
  getter right : Nil | Node(T)

  def initialize(@value)
  end

  def insert(value)
    if value <= @value
      left = @left
      if left.nil?
        @left = Node.new(value)
      else
        left.insert(value)
      end
    else
      right = @right
      if right.nil?
        @right = Node.new(value)
      else
        right.insert(value)
      end
    end
  end

  def sort : Array(T)
    sort(Array(T).new)
  end

  def sort(acc : Array(T)) : Array(T)
    left = @left
    unless left.nil?
      left.sort(acc)
    end

    acc.push(@value)

    right = @right
    unless right.nil?
      right.sort(acc)
    end

    acc
  end
end
