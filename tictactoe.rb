#!/usr/bin/ruby
puts ""
puts "Welcome to TicTacToe! We will enter numbers to mark positions on the board."
puts ""

class Game

  def initialize
    @@cells = {0=>"1", 1=>"2", 2=>"3", 3=>"4", 4=>"5", 5=>"6", 6=>"7", 7=>"8", 8=>"9"}
    show_positions
  end

  def show_positions
    puts "Board positions: \n"
    puts ""
    puts "\t\t1   2   3\n\n\t\t4   5   6\n\n\t\t7   8   9"
    puts ""
  end

  def cells
    @@cells
  end

  def self.play(symbol, position)
    if @@cells[position - 1].match?("X") || @@cells[position - 1].match?("O")
      puts "ALERT: position taken, try again"
    else
      @@cells[position - 1] = symbol
    end
    display
  end

  def self.display
    puts "Current Game: "
    puts ""
    puts "\t\t#{@@cells[0]}   #{@@cells[1]}   #{@@cells[2]}\n\n\t\t#{@@cells[3]}   #{@@cells[4]}   #{@@cells[5]}\n\n\t\t#{@@cells[6]}   #{@@cells[7]}   #{@@cells[8]}"
    puts ""
  end
end

class Player 
  attr_accessor :winner, :number_of_turns, :position
  attr_reader :number_of_turns

  def initialize(symbol)
    @symbol = symbol
    @winner = false
    @position = 0
    @number_of_turns = 0
  end

  def play(position)
    puts `clear`
    Game.play(@symbol, position)
    @number_of_turns += 1
  end
end

def check_if_player_one_wins
  win = ["X", "X", "X"] #@game.cells.values_at(0,1,2)
  case
  #rows
  when @game.cells.values_at(0,1,2) == win then @player1.winner = true
  when @game.cells.values_at(3,4,5) == win then @player1.winner = true
  when @game.cells.values_at(6,7,8) == win then @player1.winner = true
  #columns
  when @game.cells.values_at(0,3,6) == win then @player1.winner = true
  when @game.cells.values_at(1,4,7) == win then @player1.winner = true
  when @game.cells.values_at(2,5,8) == win then @player1.winner = true
  #diagonals
  when @game.cells.values_at(0,4,8) == win then @player1.winner = true
  when @game.cells.values_at(2,4,6) == win then @player1.winner = true
  end
end

def check_if_player_two_wins
  win = ["O", "O", "O"]
  case
  #rows
  when @game.cells.values_at(0,1,2) == win then @player2.winner = true
  when @game.cells.values_at(3,4,5) == win then @player2.winner = true
  when @game.cells.values_at(6,7,8) == win then @player2.winner = true
  #columns
  when @game.cells.values_at(0,3,6) == win then @player2.winner = true
  when @game.cells.values_at(1,4,7) == win then @player2.winner = true
  when @game.cells.values_at(2,5,8) == win then @player2.winner = true
  #diagonals
  when @game.cells.values_at(0,4,8) == win then @player2.winner = true
  when @game.cells.values_at(2,4,6) == win then @player2.winner = true
  end
end

puts "\tPlayer 1 is 'X'. Player 2 is 'O'. "
puts ""

def start_new_game
  reset
  until @player1.winner || @player2.winner
    player_one_play
    #first player always goes 5 times to fill the board
    if @player1.number_of_turns == 5
      puts "game ended without a winner :-/"
      prompt_to_play_again
    end
    player_two_play
  end
end

def prompt_to_play_again
  puts ""
  puts "play again? Enter Y or N"
  answer = gets.chomp.upcase
  until answer == "Y" || answer == "N"
    puts "please enter Y or N:"
    answer = gets.chomp.upcase
  end
  answer == "Y" ? start_new_game : exit
end

def reset
  @game = Game.new
  @player1 = Player.new('X')
  @player2 = Player.new('O')
end

def player_one_play
  puts "Player 1, please choose a position to mark: "
  @player1.position = gets.chomp.to_i

  while @player1.position > 9 || @player1.position < 1
    puts "Please enter a number between 1 and 9"
    @player1.position = gets.chomp.to_i
  end
  @player1.play(@player1.position)
  check_if_player_one_wins

  if @player1.winner
    puts "Player 1 wins!"
    prompt_to_play_again
  end
end

def player_two_play
  puts "Player 2, please choose a position to mark: "
  @player2.position = gets.chomp.to_i

  while @player2.position > 9 || @player2.position < 1
    puts "Please enter a number between 1 and 9"
    @player2.position = gets.chomp.to_i
  end

  @player2.play(@player2.position)
  check_if_player_two_wins

  if @player2.winner
    puts "Player 2 wins!"
    prompt_to_play_again
  end
end
start_new_game