module SteppingPiece
  def populate_moves(dir)
    moves = []
    dir.each do |direction|
      current_pos = add_pos(self.pos, direction)
      moves << current_pos if board.in_bounds?(current_pos)
    end 
    
    moves
  end
end