class Board 
  attr_reader :grid 
  
  def initalize (grid = Array.new(9){Array.new(9)})
    @grid = grid
  end 
  
  def self.populate(num_tiles)
    tiles = []
    grid = Array.new(num_tiles**0.5){Array.new(num_tiles**0.5)}
    grid.each_with_index do |row, i|
      row.each_with_index do |val, j|
        pos = [i, j]
        bomb = rand(1..10) == 1
        tiles << Tile.new(pos, bomb)
      end
    end
    
    self.new(tiles)
  end

  def neighbors(tile)
    
  end 

  def neighbor_bomb_count

  end 
end 