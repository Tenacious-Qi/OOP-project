class Game

  def start_new_game
    puts "\tPlayer 1 is 'X'. Player 2 is 'O'. "
    puts ""
    @board = Board.new
    @player1 = Player.new('X')
    @player2 = Player.new('O')
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

  def check_if_player_one_wins
    win = ["X", "X", "X"] #@board.cells.values_at(0,1,2)
    case
    #rows
    when @board.cells.values_at(0,1,2) == win then @player1.winner = true
    when @board.cells.values_at(3,4,5) == win then @player1.winner = true
    when @board.cells.values_at(6,7,8) == win then @player1.winner = true
    #columns
    when @board.cells.values_at(0,3,6) == win then @player1.winner = true
    when @board.cells.values_at(1,4,7) == win then @player1.winner = true
    when @board.cells.values_at(2,5,8) == win then @player1.winner = true
    #diagonals
    when @board.cells.values_at(0,4,8) == win then @player1.winner = true
    when @board.cells.values_at(2,4,6) == win then @player1.winner = true
    end
  end

  def check_if_player_two_wins
    win = ["O", "O", "O"]
    case
    #rows
    when @board.cells.values_at(0,1,2) == win then @player2.winner = true
    when @board.cells.values_at(3,4,5) == win then @player2.winner = true
    when @board.cells.values_at(6,7,8) == win then @player2.winner = true
    #columns
    when @board.cells.values_at(0,3,6) == win then @player2.winner = true
    when @board.cells.values_at(1,4,7) == win then @player2.winner = true
    when @board.cells.values_at(2,5,8) == win then @player2.winner = true
    #diagonals
    when @board.cells.values_at(0,4,8) == win then @player2.winner = true
    when @board.cells.values_at(2,4,6) == win then @player2.winner = true
    end
  end
end