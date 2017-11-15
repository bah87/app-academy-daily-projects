require "card"

describe Card do
  subject(:card) { Card.new(:heart, :ace) }
    
  describe "#initialize" do
    it "accepts two arguments" do
      expect {Card.new(:heart)}.to raise_error(ArgumentError)
    end
    it "only accepts a valid suit" do
      expect {Card.new(:not_a_suit, :ace)}.to raise_error(CardError)
    end
    it "only accepts a valid value" do
      expect {Card.new(:heart, :one)}.to raise_error(CardError)
    end
  end
    
  describe "#suit" do
    it "returns the card's suit" do
      expect(card.suit).to eq(:heart)
    end
  end
  
  describe "#value" do
    it "returns the card's value" do
      expect(card.value).to eq(:ace)
    end
  end
  
end