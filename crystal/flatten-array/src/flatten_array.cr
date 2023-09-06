module FlattenArray
  private def self.flatten(accu : Array, input : Array)
    input.each { |e|
      if e.is_a?(Array)
        flatten(accu, e)
      elsif !e.nil?
        accu.push(e)
      end
    }
  end

  def self.flat_type(val) # This will never be evaluated at runtime because it's
                          # called inside a typeof(...) call. Really nice.
    if val.is_a?(Array)
      flat_type(val.first)
    else
      val
    end
  end

  def self.flatten(input : Array) : Array
    flat = [] of typeof(flat_type(input))

    flatten(flat, input)

    flat
  end
end
