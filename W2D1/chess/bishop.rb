require_relative 'piece'
require_relative 'sliding_piece'

class Bishop < Piece 
  include SlidingPiece
  
  
  def self.directions
    [[1,1], [-1,-1], [1,-1], [-1,1]]
  end
  
  def symbol
    "\u2657"
  end
  
end