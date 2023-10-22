module Blackjack
  def self.parse_card(card)
    case card
    when "ace"                          then 11
    when "two"                          then 2
    when "three"                        then 3
    when "four"                         then 4
    when "five"                         then 5
    when "six"                          then 6
    when "seven"                        then 7
    when "eight"                        then 8
    when "nine"                         then 9
    when "ten", "jack", "queen", "king" then 10
    else 0
    end
  end

  def self.card_range(card1, card2)
    value1 = parse_card(card1)
    value2 = parse_card(card2)

    case value1 + value2
    when (4..11)  then "low"
    when (12..16) then "mid"
    when (17..20) then "high"
    when 21       then "blackjack"
    end
  end

  def self.first_turn(card1, card2, dealer_card)
    range = card_range(card1, card2)
    dealer_card = parse_card(dealer_card)

    case
    when card1 == "ace" && card2 == "ace"         then "P"
    when range == "blackjack" && dealer_card <= 9 then "W"
    when range == "blackjack" || range == "high"  then "S"
    when range == "mid" && dealer_card >= 7       then "H"
    when range == "mid"                           then "S"
    when range == "low"                           then "H"
    end
  end
end
