class CastleDinner
  def self.check_food?(food)
    if food == "Mushroom pasties"
      food
    end
  end

  def self.check_drink?(drink)
    if drink.downcase.includes?('i')
      drink
    end
  end

  def self.replace_drink(drink)
    check_drink?(drink) || "Apple juice"
  end
end
