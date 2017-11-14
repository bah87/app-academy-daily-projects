require_relative 'piece'

class Pawn < Piece
  
  def initialize(pos, board, color)
    super
    @start_pos = pos
  end
  
  def symbol
    "\u265f"
  end
  
  def self.directions
    []
  end
  
  def populate_moves(dummy_arr)
    moves = []
    # debugger
    
    diagonal_directions.each do |direction|
      next_pos = add_pos(self.pos, direction)
      moves << next_pos if board.occupied?(next_pos)
    end
    
    in_play_directions.each do |direction|
      next_pos = add_pos(self.pos, direction)
      moves << next_pos unless board.occupied?(next_pos)
    end
      
    first_pos = []
      
    start_directions.each_with_index do |direction, idx|
      next_pos = add_pos(self.pos, direction)
      # first_pos = next_pos unless idx > 0
      if idx == 0
        first_pos = next_pos
        moves << next_pos unless board.occupied?(next_pos)
      else
        moves << next_pos unless board.occupied?(first_pos) || board.occupied?(next_pos)
      end
    end
    
    moves.uniq
  end
    
  private 
  
  def diagonal_directions 
    if @start_pos.first == 1 
      [[1,-1], [1,1]]
    else 
      [[-1,1], [-1,-1]]
    end
  end
  
  def start_directions
    if @start_pos.first == 1 
      [[1,0], [2,0]]
    else 
      [[-1,0], [-2,0]]
    end
  end
  
  def in_play_directions
    if @start_pos.first == 1 
      [[1,0]]
    else 
      [[-1,0]]
    end
  end
end