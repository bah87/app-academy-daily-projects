require "hand"

describe Hand do
  let(:deck) {double("deck")}
  subject(:hand) { Hand.new(deck) }
  
  describe "#cards" do
    it "returns an array with 5 cards" do
      allow(deck).to receive(:draw).and_return("card")
      expect(hand.cards.length).to eq(5)
      
    end
  end
  
  describe "#strength_of_hand" do
    
    it "returns strength of the hand"
    
  end
  
end