# frozen_string_literal: true

# controls logic of tic-tac-toe
class Game
  attr_accessor :board, :p1, :p2, :play_again

  def initialize
    @p1 = Player.new('X')
    @p2 = Player.new('O')
    @board = Board.new
    @play_again = false
  end

  def play_game
    until over?
      p1_turn unless @p2.winner
      p2_turn unless over?
    end
  end

  def over?
    @p1.turns == 5 || @p1.winner || @p2.winner
  end

  def tied?
    @p1.turns == 5 && !@p1.winner && !@p2.winner
  end

  def p1_turn
    puts 'Player 1, please choose a position to mark:'
    input = gets.chomp.to_i # need to create player method that verifies input
    @board.pos_taken?(input) ? p1_turn : @board.mark(input - 1, 'X')
    @board.display
    @p1.assign_winner if @board.three_x?
    declare_winner
  end

  def p2_turn
    puts 'Player 2, please choose a position to mark:'
    input = gets.chomp.to_i
    @board.pos_taken?(input) ? p2_turn : @board.mark(input - 1, 'O')
    @board.display
    @p2.assign_winner if @board.three_o?
    declare_winner
  end

  def verify(input)
    until input.between?(1, 9)
      puts 'Please enter a valid board position:'
      input = gets.chomp.to_i
    end
    input
  end

  def declare_winner
    puts 'game ended without a winner :-/' if tied?
    puts 'Player 1 wins!' if @p1.winner
    puts 'Player 2 wins!' if @p2.winner
    prompt_to_play_again  if over?
  end

  def prompt_to_play_again
    puts "\nplay again? Enter Y or N"
    answer = gets.chomp.upcase
    until answer.match?(/[YN]/)
      puts 'please enter Y or N:'
      answer = gets.chomp.upcase
    end
    @play_again = true if answer.match?(/[Y]/)
    @play_again = false if answer.match?(/[N]/)
  end
end
