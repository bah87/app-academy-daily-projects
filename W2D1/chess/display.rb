require 'colorize'
require_relative 'cursor'
require_relative 'board'

class Display
  def initialize(board)
    @cursor = Cursor.new([0,0],board)
  end
  
  def render
    board = @cursor.board
    8.times do |i|
      row = ''
      8.times do |j|
        color = (@cursor.cursor_pos == [i,j] ? :red : :black) 
        #row += board[[i,j]]
        if board[[i,j]].nil?
          row += '_'.colorize(color)
        else
          row += '*'.colorize(color)
        end
      end
      puts row
    end
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