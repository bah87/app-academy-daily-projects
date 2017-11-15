class Hand 
  
  attr_reader :cards
  
  def initialize(deck)
    @cards = []
    5.times {@cards << deck.draw}
    
  end
  
  def strength_of_hand
    
  end
  
  def flush?
    self.cards.all? { |card| card.suit == self.cards.first.suit  }
  end
  
  def straight?
    values = []
    self.cards.each do |card|
      values << Card::VALUES.index(card.value)
    end
    min = values.min
    max = values.max
    straight = (min..max).to_a
    values.sort == straight
  end
  
  def straight_flush?
    straight? && flush?
  end
  
  def of_a_kind(n)
    self.cards.each do |card|
      return card if self.cards.count(card) == n
    end
    nil
  end
  
  def two_pair?
    first_pair_card = self.of_a_kind(2)
    return false unless first_pair_card
    remaining = self.cards.reject do |card|
       card.value == first_pair_card.value
     end
    
  end
  
end