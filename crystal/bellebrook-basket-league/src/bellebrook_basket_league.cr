module TicketingReservation
  getter tickets_available : UInt32
  getter stadium : String

  def order_ticket?
    enough = @tickets_available >= 100

    if enough
      @tickets_available -= 1
    end

    enough
  end

  def order_message(name : String)
    if order_ticket?
      "#{name}, your purchase was successful, your ticket number \
       is ##{@tickets_available + 1}, and the game is played at the #{@stadium} \
       stadium."
    else
      "#{name}, your purchase was unsuccessful, there are not enough \
       tickets available."
    end
  end
end

class TicketSystem
  include TicketingReservation

  def initialize(@tickets_available, @stadium)
  end
end
