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

  def self.flatten(input : Array) : Array
    flat = [] of Int32

    flatten(flat, input)

    flat
  end
end
