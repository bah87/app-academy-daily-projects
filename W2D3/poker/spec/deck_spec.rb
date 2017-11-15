require "deck"

describe Deck do
  subject(:deck) { Deck.new }
  
  describe "::make_deck" do
    it "makes a full deck" do
      expect(deck.cards.length).to eq(52)
    end
  end
  
  describe "#cards" do
    it "returns an array" do
      expect(deck.cards).to be_an(Array)
    end
    
    it "returns an array of card objects" do
      expect(deck.cards).to all(be_a(Card))
    end
  end
  
  describe "#draw" do
    it "returns a card from the deck" do
      card = deck.draw
      expect(card).to be_a(Card)
    end
    
    it "removes a card from the deck" do
      old_cards = deck.cards.dup
      card = deck.draw
      expect(deck.cards).not_to include(card)
      expect(deck.cards.length).to eq(old_cards.length - 1)
    end
  end
  
  describe "#shuffle!" do
    it "shuffles the deck" do
      old_deck = deck.cards.dup
      deck.shuffle!
      expect(deck.cards).not_to eq(old_deck)
    end
  end
  
end