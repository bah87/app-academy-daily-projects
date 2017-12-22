class Tile
  attr_reader :pos, :bomb, :revealed, :flagged 
  
  def initialize(pos, bomb, revealed = false, flagged=false) 
    @pos = pos
    @bomb = bomb
    @revealed = revealed
    @flagged = flagged
  end 
  
  def reveal 
    @revealed = true 
  end 
end 