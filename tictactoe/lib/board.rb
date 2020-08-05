# frozen_string_literal: true

# controls display of tic-tac-toe board and allows Players to mark itself
class Board
  attr_reader :cells
  def initialize
    @cells = [1, 2, 3, 4, 5, 6, 7, 8, 9]
  end

  def show_positions
    puts <<-HEREDOC
    
  Welcome to TicTacToe! We will enter numbers to mark positions on the board.

    Board positions:

      1   2   3

      4   5   6

      7   8   9

  Player 1 is 'X'. Player 2 is 'O'.

    HEREDOC
  end

  def mark(pos, symbol)
    @cells[pos] = symbol
  end

  def pos_taken?(pos)
    @cells[pos - 1].to_s.match?(/[XO]/)
  end

  def three_x?
    win_lines.any? { |w| @cells.values_at(w[0], w[1], w[2]).all?('X') }
  end

  def three_o?
    win_lines.any? { |w| @cells.values_at(w[0], w[1], w[2]).all?('O') }
  end

  def win_lines
    [
      [0, 1, 2], [3, 4, 5], [6, 7, 8], [0, 3, 6],
      [1, 4, 7], [2, 5, 8], [0, 4, 8], [2, 4, 6]
    ]
  end

  def display
    clear_terminal
    puts <<-HEREDOC
    Current Game:

      #{@cells[0]}   #{@cells[1]}   #{@cells[2]}

      #{@cells[3]}   #{@cells[4]}   #{@cells[5]}

      #{@cells[6]}   #{@cells[7]}   #{@cells[8]}

    HEREDOC
  end

  def clear_terminal
    puts `clear`
  end
end
