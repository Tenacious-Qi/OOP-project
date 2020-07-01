# frozen_string_literal: true

# controls logic of tic-tac-toe
class Game
  attr_accessor :board, :p1, :p2

  def initialize
    @board = Board.new
    @p1 = Player.new('X')
    @p2 = Player.new('O')
    play_game
  end

  def play_game
    until p1.winner || p2.winner
      p1_go
      p1.turns += 1
      # first player always goes 5 times to fill the board
      if p1.turns == 5
        puts 'game ended without a winner :-/'
        prompt_to_play_again
      end
      p2_go
    end
  end

  def p1_go
    verify_p1_input
    pos_taken?(p1.pos) ? p1_go : board.cells[p1.pos - 1] = 'X'
    board.display
    check_for_win
    declare_winner
  end

  def p2_go
    verify_p2_input
    pos_taken?(p2.pos) ? p2_go : board.cells[p2.pos - 1] = 'O'
    board.display
    check_for_win
    declare_winner
  end

  def verify_p1_input
    puts 'Player 1, please choose a position to mark:'
    p1.pos = gets.chomp.to_i
    until p1.pos.between?(1, 9)
      puts 'Please enter a number between 1 and 9'
      p1.pos = gets.chomp.to_i
    end
  end

  def verify_p2_input
    puts 'Player 2, please choose a position to mark:'
    p2.pos = gets.chomp.to_i
    until p2.pos.between?(1, 9)
      puts 'Please enter a number between 1 and 9'
      p2.pos = gets.chomp.to_i
    end
  end

  def pos_taken?(position)
    board.cells[position - 1].to_s.match?(/[XO]/)
  end

  def check_for_win
    @board.winning_positions.each do |arr|
      if @board.cells.values_at(arr[0], arr[1], arr[2]).all?('X')
        @p1.winner = true
      elsif @board.cells.values_at(arr[0], arr[1], arr[2]).all?('O')
        @p2.winner = true
      end
    end
  end

  def declare_winner
    puts 'Player 1 wins!' if p1.winner
    puts 'Player 2 wins!' if p2.winner
    prompt_to_play_again  if p1.winner || p2.winner
  end

  def prompt_to_play_again
    puts 'play again? Enter Y or N'
    answer = gets.chomp.upcase
    until answer.match?(/[YN]/)
      puts 'please enter Y or N:'
      answer = gets.chomp.upcase
    end
    answer.include?('Y') ? Game.new : exit
  end
end
