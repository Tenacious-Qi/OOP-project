# frozen_string_literal: true

# controls logic of tic-tac-toe
class Game
  attr_accessor :board, :p1, :p2

  def initialize
    @p1 = Player.new('X')
    @p2 = Player.new('O')
    @board = Board.new
  end

  def play_game
    board.show_positions
    until over?
      p1_go
      p1.turns += 1
      if over?
        puts 'game ended without a winner :-/'
        prompt_to_play_again
      end
      p2_go
    end
  end

  def over?
    # first player always goes 5 times to fill the board
    return true if p1.turns == 5 || p1.winner || p2.winner

    false
  end

  def p1_go
    verify_p1_input
    pos_taken?(p1.pos) ? p1_go : board.cells[p1.pos - 1] = 'X'
    board.display
    assign_winner
    declare_winner
  end

  def p2_go
    verify_p2_input
    pos_taken?(p2.pos) ? p2_go : board.cells[p2.pos - 1] = 'O'
    board.display
    assign_winner
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

  def assign_winner
    p1.winner = true if three_x?
    p2.winner = true if three_o?
  end

  def three_x?
    board.winning_positions.each do |arr|
      return true if board.cells.values_at(arr[0], arr[1], arr[2]).all?('X') 
    end
    false
  end

  def three_o?
    board.winning_positions.each do |arr|
      return true if board.cells.values_at(arr[0], arr[1], arr[2]).all?('O')
    end
    false
  end

  def declare_winner
    puts 'Player 1 wins!' if p1.winner
    puts 'Player 2 wins!' if p2.winner
    prompt_to_play_again  if over?
  end

  def prompt_to_play_again
    puts 'play again? Enter Y or N'
    answer = gets.chomp.upcase
    until answer.match?(/[YN]/)
      puts 'please enter Y or N:'
      answer = gets.chomp.upcase
    end
    if answer.match?(/[Y]/)
      next_game = Game.new
      next_game.play_game
    end
    exit
  end
end
