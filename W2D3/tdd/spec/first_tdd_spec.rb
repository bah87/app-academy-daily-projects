require 'first_tdd'

describe Array do 
  
  describe "#my_uniq" do
    subject(:array) { [1,2,3] }
    
    it "returns array with duplicates removed" do
      expect([1,2,1,3,3].my_uniq).to eq(array)
    end
    
    it "returns identical array if given a unique array" do
      expect(array.my_uniq).to eq(array)
    end
    
    it "does not return original array" do
      expect(array.my_uniq).not_to be(array)
    end
    
    it "does not call built-in #uniq method" do
      expect(array).not_to receive(:uniq)
      array.my_uniq
    end
    
  end
  
  describe "#two_sum" do
    
    it "returns an array of pairs that sum to zero" do
      expect([-1, 5, 2, -2, 1].two_sum).to eq([[0,4], [2,3]])
    end
    
    it "returns an empty array if there are no pairs" do
      expect([1,2,3].two_sum).to be_empty
    end
    
    it "does not count zeroes twice" do
      expect([-1,0,1,2].two_sum).to eq([[0,2]])
    end
    
    it "does not count a pair twice" do
      array = [1,2,2,-1]
      expect(array.two_sum).to eq([[0,3]])
    end
    
    it "sorts the array of pairs dictionary-wise" do
      array = [0,0,0]
      expect(array.two_sum).to eq([[0,1], [0,2], [1,2]])
    end
    
  end
  
  describe "#my_transpose" do
    subject(:rows) { [[0,1,2], [3,4,5], [6,7,8]] }
    let(:columns) { [[0,3,6], [1,4,7], [2,5,8]] }
    
    it "transposes a square array" do
      expect(rows.my_transpose).to eq(columns)
    end
    
    it "returns identical array when called twice" do
      expect(columns.my_transpose).to eq(rows)
    end
    
    it "does not mutate original array" do
      rows.my_transpose
      expect(rows).to eq([[0,1,2], [3,4,5], [6,7,8]])
    end
    
  end
  
  describe "#stock_picker" do
    subject(:prices) { [2, 5, 9, 1] }
    let(:decreasing) { [6, 4, 3, 1] }
    
    
    it "makes biggest possible profit" do
      expect(prices.stock_picker).to eq([0,2])
    end
    
    it "does not sell before it buys" do
      days = prices.stock_picker
      expect(days.last).to be > (days.first)
    end
    
    it "does not buy and sell on same day" do
      days = decreasing.stock_picker
      expect(days.first).not_to eq(days.last)
    end
  end
  
end

describe Towers do
  
  subject(:game) { Towers.new }
  
  describe "#towers" do
    
    it "sets up towers correctly" do
      expect(game.towers).to eq([[3,2,1], [], []])
    end    
  
  end
  
  describe "#move" do 
    
    it "accepts two arguments" do
      expect { game.move(1) }.to raise_error(ArgumentError)
    end
    
    it "only accepts integers as arguments" do
      expect { game.move("1","2") }.to raise_error(TypeError)
    end
    
    it "updates @towers array" do
      game.move(0,1)
      expect(game.towers).not_to eq([[3,2,1], [], []])
    end
    
    it "correctly places disc" do
      game.move(0,1)
      expect(game.towers).to eq([[3,2], [1], []])
    end
    
    it "places disc on empty tower" do
      expect {game.move(0,1)}.not_to raise_error
    end
    
    it "does not place larger disc on top of smaller disc" do
      game.move(0,1)
      expect {game.move(0,1)}.to raise_error(DiscError)
    end
    
    it "does not move from empty tower" do
      expect { game.move(1,2) }.to raise_error(DiscError)
    end
    
  end
  
  describe "#won?" do
    it "returns true if game is over" do
      winning_moves = [[0,1],[0,2],[1,2],[0,1],[2,0],[2,1],[0,1]]
      winning_moves.each do |move|
        from, to = move
        game.move(from, to)
      end
      
      expect(game.won?).to be true      
    end
  end
  
end