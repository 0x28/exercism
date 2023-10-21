class PasswordLock
  def initialize(@password : Int32 | String | Float64)
  end

  def encrypt()
    pwd = @password
    if pwd.is_a?(Int32)
      @password = (pwd / 2).round;
    elsif pwd.is_a?(String)
      @password = pwd.reverse
    else
      @password = pwd * 4
    end
  end

  def unlock?(password)
    other = PasswordLock.new(password)
    other.encrypt
    if @password == other.@password
      "Unlocked"
    end
  end
end
