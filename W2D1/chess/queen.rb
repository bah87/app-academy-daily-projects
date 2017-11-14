require_relative 'piece'
require_relative 'rook'
require_relative 'bishop'
require_relative 'sliding_piece'

class Queen < Piece
  include SlidingPiece
  
  def self.directions
    Rook.directions + Bishop.directions
  end
  
  def symbol
    "\u2655"
  end
end