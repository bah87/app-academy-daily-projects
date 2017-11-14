require_relative 'board'
require_relative 'display'
require_relative 'player'

class Game 
  LETTER = ('a'..'h').map.with_index {|el, idx| [el, idx]}.to_h
  NUMBER = (1..8).map {|el| [el, -1*el+8]}.to_h
  
  def initialize(board, player_one, player_two)
    @board = board 
    @current_player = player_one
    @next_player = player_two
  end
  
  def play
    until game_over?
      puts "#{@current_player.name}, it's your turn"
      sleep(2)
      play_turn
      #
      # ALERT PLAYER IF THEY'RE IN CHECK 
      #
      switch_player
    end
    
    puts "Congratulations, #{@next_player}, you win!"
    
  end
  
  def game_over?
    colors = [@current_player.color, @next_player.color]
    colors.each do |color|
      return true if board.check_mate?(color)
    end
    false
  end
  
  def switch_player
    @current_player, @next_player = @next_player, @current_player
  end
  
  
  def play_turn
    display = Display.new(board)
    begin 
      system("clear")
      display.render
      
      print "From: "
      from = handle_user_input
      raise NoPieceError unless board.in_bounds?(from) && board.occupied?(from)
      
      print "To: "
      to = handle_user_input
      piece = board[from]
      raise InvalidMoveError unless piece.valid_moves.include?(to) && piece.color == @current_player.color
      
      board.move_piece(from, to)
    rescue InvalidMoveError
      puts "Invalid move."
      sleep(2)
      retry
    rescue NoPieceError
      puts "No piece to move."
      sleep(2)
      retry
    end
  end
  
  def handle_user_input
    response = gets.chomp.split(//)
    [NUMBER[response.last.to_i], LETTER[response.first]]
  end
  
  def get_move
    
  end
  
  attr_reader :board
end

red = Player.new('red', :red)
black = Player.new('black', :black)
b = Board.new
game = Game.new(b, red, black)
game.play