class Card
  SUITS = [:heart, :diamond, :spade, :club]
  VALUES = [:two, :three, :four, :five, :six, :seven, :eight, :nine, :ten, :jack, :queen, :king, :ace]
  
  attr_reader :suit, :value
  
  def initialize(suit, value)
    raise CardError unless SUITS.include?(suit) && VALUES.include?(value)
    @suit, @value = suit, value 
  end
end

class CardError < StandardError; end