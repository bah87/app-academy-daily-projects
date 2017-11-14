require 'colorize'
require_relative 'cursor'
# require_relative 'board'

class Display
  def initialize(board)
    @cursor = Cursor.new([0,0],board)
  end
  
  def render
    board = @cursor.board
    shades = [:light_yellow, :yellow]
    8.times do |i|
      row = (-1*i+8).to_s + ": "
      8.times do |j|
        color = (@cursor.cursor_pos == [i,j] ? :blue : board[[i,j]].color )
         
        row += board[[i,j]].to_str.colorize(color: color, background: shades[(i+j)%2])
        row += ' ' unless j == 7
        
      end
      puts row
    end
    puts " : " + ('a'..'h').to_a.join(' ')
  end
  
  def update_cell_color
    render
    5.times do |i|
      @cursor.get_input
      system 'clear'
      render
      
    end
  end
end