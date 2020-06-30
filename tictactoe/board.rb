# frozen_string_literal: true

# controls display of tic-tac-toe board and allows Players to mark itself
class Board
  def initialize
    @@cells = [1, 2, 3, 4, 5, 6, 7, 8, 9]
    show_positions
  end

  def show_positions
    puts <<-HEREDOC
    
  Welcome to TicTacToe! We will enter numbers to mark positions on the board.

    Board positions:

      1   2   3

      4   5   6

      7   8   9

    HEREDOC
  end

  def winning_positions
    [
      [0, 1, 2], [3, 4, 5], [6, 7, 8], [0, 3, 6],
      [1, 4, 7], [2, 5, 8], [0, 4, 8], [2, 4, 6]
    ]
  end

  def cells
    @@cells
  end

  def self.play(symbol, position)
    if @@cells[position - 1] == 'X' || @@cells[position - 1] == 'O'
      warn 'ALERT: position taken, try again'
    else
      @@cells[position - 1] = symbol
    end
    display
  end

  def self.display
    puts <<-HEREDOC
    Current Game:

      #{@@cells[0]}   #{@@cells[1]}   #{@@cells[2]}

      #{@@cells[3]}   #{@@cells[4]}   #{@@cells[5]}

      #{@@cells[6]}   #{@@cells[7]}   #{@@cells[8]}

    HEREDOC
  end
end
