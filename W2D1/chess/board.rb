require_relative 'king'
require_relative 'queen'
require_relative 'knight'
require_relative 'bishop'
require_relative 'rook'
require_relative 'pawn'
require_relative 'null_piece'
require 'byebug'
require_relative 'display'

class Board
  attr_reader :grid
  def initialize
    @grid = populate_grid
  end
  
  def play
    display = Display.new(self)
    letter = ('a'..'h').map.with_index {|el, idx| [el, idx]}.to_h
    number = (1..8).map {|el| [el, -1*el+8]}.to_h
    while true
      system("clear")
      display.render
      print "From: "
      from_in = gets.chomp.split(//)
      from_out = [number[from_in.last.to_i], letter[from_in.first]]
      print "To: "
      to_in = gets.chomp.split(//)
      to_out = [number[to_in.last.to_i], letter[to_in.first]]
      move_piece(from_out, to_out)
    end
  end
  
  def dup
    copy = Board.new
    8.times do |row_idx|
      8.times do |col_idx|
        piece = self[[row_idx, col_idx]]
        new_piece = nil
        if piece.class == NullPiece
          new_piece = NullPiece.instance
        else
          new_piece = piece.class.new(piece.pos, copy, piece.color)
        end
        copy[[row_idx, col_idx]] = new_piece
      end 
    end 
    
    copy
  end 
  
  def populate_grid
    grid = Array.new(8) { [] }
    
    colors = [:black, :black, nil, nil, nil, nil, :red, :red]
    type_of_row = [:back, :pawn, :null, :null, :null, :null, :pawn, :back]
    (0..7).each do |row|
      grid[row] = piece_row(row, colors[row], type_of_row[row])
    end 
    
    grid
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
    raise NoPieceError unless occupied?(start_pos)
    # debugger
    piece = self[start_pos]
    if piece.moves.include?(end_pos)
      self[end_pos] = piece 
      piece.pos = end_pos
      self[start_pos] = NullPiece.instance
    else 
      raise InvalidMoveError.message("That move is not valid")
    end
  end
  
  def empty_row
    Array.new(8) { NullPiece.instance }
  end
  
  def pawn_row(row, color)
    pawn_pieces = []
    8.times do |col|
      pawn_pieces << Pawn.new([row, col], self, color)
    end 
    
    pawn_pieces
  end
  
  def piece_row(row, color, type)
    return empty_row if type == :null
    return pawn_row(row, color) if type == :pawn
    piece_row = Array.new(8)
    classes = [Rook, Knight, Bishop, Queen, King, Bishop, Knight, Rook]
    
    (0..7).each do |col|
      piece_row[col] = classes[col].new([row, col], self, color)
    end
    
    piece_row
  end
  
  def in_bounds?(pos)
    pos.all? {|x| x.between?(0,7)}
  end
  
  def occupied?(pos)
    !self[pos].nil? && self[pos].class != NullPiece
  end
  
  def in_check?(color)
    king = @grid.flatten.select {|piece| piece.color == color && piece.class == King}.first
    enemies = @grid.flatten.select {|piece| piece.color != color && piece.class != NullPiece}
    enemies.each do |enemy|
      return true if enemy.moves.include?(king.pos)
    end
    return false
  end
  
  def check_mate?(color)
    return false unless in_check?(color)
    subjects = @grid.flatten.select {|piece| piece.color == color}
    subjects.each do |subject|
      return false unless subject.valid_moves.empty?
    end 
    true
  end
end

class NoPieceError < StandardError; end
class InvalidMoveError < StandardError; end

if __FILE__ == $PROGRAM_NAME
  board = Board.new
  board.play
  # display = Display.new(board)
  # display.render
  # pawn = board[[1,0]]
  # puts "created pawn"
  # p pawn.populate_moves([3])
  # puts "populated"
  # p pawn.moves
  
  # 
  # start = [1,0]
  # finish = [3,0]
  # board.move_piece(start, finish)
  # board.move_piece()
  # display.render
end