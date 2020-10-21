class Game 
  attr_accessor :board, :player_1, :player_2
  def initialize(player_1 = Players::Human.new("X"), player_2 = Players::Human.new("O"), board = Board.new)
    @player_1 = player_1
    @player_2 = player_2
    @board = board
  end
    WIN_COMBINATIONS = [
  [0,1,2],
  [3,4,5],
  [6,7,8],
  [0,3,6],
  [1,4,7],
  [2,5,8],
  [0,4,8],
  [2,4,6] ]
  
  def current_player
    board.turn_count % 2 == 0 ? player_1 : player_2
  end
  def won?
     WIN_COMBINATIONS.each do |win_combination|
     win_index_1 = win_combination[0]
     win_index_2 = win_combination[1]
     win_index_3 = win_combination[2]

     position_1 = @board.cells[win_index_1]
     position_2 = @board.cells[win_index_2]
     position_3 = @board.cells[win_index_3]

     if position_1 == "X" && position_2 == "X" && position_3 == "X"
       return win_combination
     elsif position_1 == "O" && position_2 == "O" && position_3 == "O"
       return win_combination
     end
   end
   false
 end
  def draw?
    @board.full? && !won? ? true : false
  end
  def over?
    won? || draw? ? true : false
  end
  def winner 
   if won?
       @board.cells[won?[0]]
     else
       nil
     end
   end
  def turn
     puts "Please enter a number 1 - 9:"
     player = current_player
     input = player.move(@board)
     if @board.valid_move?(input)
      @board.update(input, player)
      @board.display
     else
       turn
   end
 end
  def play 
    turn until over?
    if won?
      puts "Congratulations #{winner}!"
    elsif draw?
      puts "Cat's Game!"
    end
  end
  def self.start
    puts "Welcome to Tic Tac Toe!"
    puts "Please choose player mode: 0, 1, 2."
    player_mode = gets.strip.to_i
          if player_mode == 0
                game = Game.new(Players::Computer.new("X"), Players::Computer.new("O"))
          elsif player_mode == 1
            puts "Would you like to play first as X? [Y/N]"
              input = gets.strip
              if input == "Y" || input == "y"
                game = Game.new(Players::Human.new("X"),Players::Computer.new("O"))
              elsif  input == "N" || input == "n"
                exit
              else
              game = Game.new(Players::Computer.new("X"), Players::Human.new("O"))
            end
          else
            game = Game.new
            puts "Let's go!"
          end
      game.play
      puts "Would you like to play again? [Y/N]"
      input = gets.strip
      if input == "y"
        Game.start
      else
        exit
      end
    end
  end