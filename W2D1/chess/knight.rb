require_relative 'piece'
require_relative 'stepping_piece'

class Knight < Piece
  include SteppingPiece
  
  def self.directions
    [[1,2], [2,1], [1,-2], [-2, 1], [-1,-2], [-1,2], [2, -1], [-2,-1]]
  end
  
  def symbol
    "\u2658"
  end
  
end