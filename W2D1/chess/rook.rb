require_relative 'piece'
require_relative 'sliding_piece'

class Rook < Piece
  include SlidingPiece
  
  def self.directions
    [[0,1], [1,0], [-1,0], [0,-1]]
  end
  
  def symbol
    "\u2656"
  end
end