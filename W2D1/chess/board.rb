class Board
  attr_reader :grid
  def initialize
    @grid= []
    (0..7).each do |row|
      case row
      when 0,7
        @grid << back_row
      when 1,6
        @grid << pawn_row
      else
        @grid << empty_row
      end
    end
  end
  
  def []=(pos, value)
    x, y = pos
    @grid[x][y] = value
  end
  
  def [](pos)
    x, y = pos
    @grid[x][y]
  end
  
  def move_piece(start_pos, end_pos)
    raise NoPieceError if self[start_pos].nil?
    
    piece = self[start_pos]
    if piece.moves.include?(end_pos)
      self[end_pos] = piece 
      self[start_pos] = NullPiece.new
    else 
      raise InvalidMoveError
    end
  end
  
  def empty_row
    Array.new(8) {nil} #NullPiece.new}
  end
  
  def pawn_row
    Array.new(8) {Piece.new([0,0], self)}
  end
  
  def back_row
    Array.new(8) {Piece.new([0,0], self)}
  end
  
  def in_bounds?(pos)
    pos.all? {|x| x.between?(0,7)}
  end
  
  def occupied?(pos)
    self[current_pos].class == Piece
  end
  
end

class NoPieceError < StandardError; end
class InvalidMoveError < StandardError; end