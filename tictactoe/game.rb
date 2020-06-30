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
    check_who_wins

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
    check_who_wins

    if @player2.winner
      puts "Player 2 wins!"
      prompt_to_play_again
    end
  end

  def check_who_wins
    @board.winning_positions.each do |arr|
      if @board.cells.values_at(arr[0], arr[1], arr[2]).all? { |v| v == 'X'}
        @player1.winner = true
      elsif @board.cells.values_at(arr[0], arr[1], arr[2]).all? { |v| v == 'O'}
        @player2.winner = true
      end
    end
  end
end
