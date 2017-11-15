require_relative "card"

class Deck 
  
  attr_reader :cards
  
  def initialize
    @cards = Deck.make_deck
  end
  
  def self.make_deck
    cards = []
    Card::SUITS.each do |suit|
      Card::VALUES.each do |value|
        new_card = Card.new(suit, value)
        cards << new_card
      end
    end
    cards
  end
  
  def draw
    self.cards.pop
  end
  
  def shuffle!
    self.cards.shuffle!
  end
end