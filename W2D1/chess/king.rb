require_relative 'piece'
require_relative 'queen'
require_relative 'stepping_piece'

class King < Piece
  include SteppingPiece
  
  def self.directions
    Queen.directions
  end
  
  def symbol
    "\u2654"
  end
  
end