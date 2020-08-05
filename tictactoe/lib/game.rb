# frozen_string_literal: true

# controls logic of tic-tac-toe
class Game
  attr_reader :p1, :p2, :board
  attr_accessor :play_again
  def initialize
    @p1 = Player.new
    @p2 = Player.new
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
    puts 'Player 1, please mark an open position on the board:'
    input = gets.chomp.to_i
    valid?(input) ? @board.mark(input - 1, 'X') : p1_turn
    @p1.increment_turns
    @board.display
    assign_winner
    declare_winner
  end

  def p2_turn
    puts 'Player 2, please mark an open position on the board:'
    input = gets.chomp.to_i
    valid?(input) ? @board.mark(input - 1, 'O') : p2_turn
    @board.display
    assign_winner
    declare_winner
  end

  def valid?(input)
    input.between?(1, 9) && @board.pos_taken?(input) == false
  end

  def assign_winner
    @p1.assign_winner if @board.three_x?
    @p2.assign_winner if @board.three_o?
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
