class Piece
  attr_reader :board, :color
  attr_accessor :pos
  
  def initialize(pos, board, color)
    @pos = pos 
    @board = board
    @color = color
  end
  
  def add_pos(pos0, pos1)
    x0, y0 = pos0
    x1, y1 = pos1
    [x0 + x1, y0 + y1]
  end
  
  def moves 
    populate_moves(self.class.directions).reject {|x| board[x].color == self.color}    
  end
  
  def valid_moves
    valid = []
    moves.each do |move|
      copy = board.dup
      copy.move_piece(self.pos, move)
      valid << move unless copy.in_check?(color)
    end
    valid
  end
  
  def to_str
    symbol.to_s
  end
end