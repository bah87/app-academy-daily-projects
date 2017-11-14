require 'byebug'
module SlidingPiece
  def populate_moves(dir)
    moves = []
    
    dir.each do |direction|
      #debugger
      current_pos = add_pos(self.pos, direction)
      until !self.board.in_bounds?(current_pos) || self.board.occupied?(current_pos)  
        break unless board.in_bounds?(current_pos)
        moves << current_pos
        current_pos = add_pos(current_pos, direction)
      end 
      moves << current_pos if board.in_bounds?(current_pos)
    end 
    
    moves 
  end
end