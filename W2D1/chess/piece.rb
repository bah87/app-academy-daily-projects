require 'Singleton'

class Piece
  def initialize(pos, board, color)
    @pos = pos 
    @board = board
    @color = color
  end
  
  def symbol
    self.class.symbol
  end
  
  attr_reader :pos, :board, :color
end

class NullPiece < Piece
  include Singleton
  @@symbol = :N
end

module PieceOperations
  def add_pos(pos0, pos1)
    x0, y0 = pos0
    x1, y1 = pos1
    [x0 + x1, y0 + y1]
  end
  
  def moves 
    populate_moves(self.class.directions).reject {|x| board[x].color == self.color}    
  end
end

module SlidingPiece
  include PieceOperations
  def populate_moves(dir)
    moves = []
    
    dir.each do |direction|
      current_pos = add_pos(self.pos, direction)
      until self.board.occupied?(current_pos)
        break unless board.in_bounds?(current_pos)
        moves << current_pos 
        current_pos = add_pos(current_pos, direction)
      end 
      moves << current_pos if board.in_bounds?(current_pos)
    end 
    
    moves 
  end
  
end

module SteppingPiece
  include PieceOperations
  
  def populate_moves(dir)
    moves = []
    dir.each do |direction|
      current_pos = add_pos(self.pos, direction)
      moves << current_pos if board.in_bounds?(current_pos)
    end 
    
    moves
  end
  
end

class King < Piece
  include SteppingPiece
  @@symbol = :Ki
  
  def self.directions
    Queen.directions
  end
  
end

class Knight < Piece
  include SteppingPiece
  @@symbol = :Kn
  
  def self.directions
    [[1,2], [2,1], [1,-2], [-2, 1], [-1,-2], [-1,2], [2, -1], [-2,-1]]
  end
  
end


class Rook < Piece
  include SlidingPiece
  @@symbol = :R
  
  def self.directions
    [[0,1], [1,0], [-1,0], [0,-1]]
  end
end

class Bishop < Piece 
  include SlidingPiece
  @@symbol = :B
  
  def self.directions
    [[1,1], [-1,-1], [1,-1], [-1,1]]
  end
end

class Queen < Piece
  include SlidingPiece
  @@symbol = :Q
  
  def self.directions
    Rook.directions + Bishop.directions
  end
end

class Pawn < Piece
  include PieceOperations
  @@symbol = :P
  
  def initialize(pos, board, color)
    super
    @start_position = pos
  end
  
  def self.directions
    []
  end
  
  
  def populate_moves(dummy_arr)
    moves = []
    
    diagonal_directions.each do |direction|
      next_pos = add_pos(self.pos, direction)
      moves << next_pos if board.occupied?(next_pos)
    end
    
    in_play_directions.each do |direction|
      next_pos = add_pos(self.pos, direction)
      moves << next_pos unless board.occupied?(next_pos)
    end
      
      
    start_direction.each_with_index do |direction, idx|
      next_pos = add_pos(self.pos, direction)
      if idx == 0
        first_pos = next_pos
        moves << next_pos unless board.occupied?(next_pos)
      else
        moves << next_pos unless board.occupied?(first_pos) || board.occupied?(next_pos)
      end
    end
    
    return moves
        
  end
      
  
  def diagonal_directions 
    if @start_pos.last == 1 
      [[1,1], [-1,1]]
    else 
      [[1,-1], [-1,-1]]
    end
  end
  
  def start_directions
    if @start_pos.last == 1 
      [[0,1], [0,2]]
    else 
      [[0,-1], [0,-2]]
    end
  end
  
  def in_play_directions
    if @start_pos.last == 1 
      [[0,1]]
    else 
      [[0,-1]]
    end
  end
end



