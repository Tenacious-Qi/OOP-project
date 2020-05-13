class CodeBreaker
  
  def initialize(board, codemaker)
    @board = board
    @codemaker = codemaker
  end
   
  def human_break_code
    #after four colors are placed, increment @number_of_rounds by 1. 
    #display board with positions updated to show colors
    until @board.number_of_rounds == 12
      round_complete = false
      i = 0
      until round_complete
        print "\nmake a guess at position #{i + 1}: "
        color = gets.chomp.strip.downcase
        until color.match?(/^red$|^green$|^magenta$|^yellow$|^blue$|^black$/) && !@board.positions.include?(color)
          puts '\n## entry must match available colors (colors do not repeat)'
          print "\nPlease enter a valid color for position #{i + 1}: "
          color = gets.chomp.strip.downcase
        end
        if color.match?(/^red$|^green$|^magenta$|^yellow$|^blue$|^black$/)
          @board.positions[i] = color
          @board.colors_placed += 1
          i += 1
        end
        round_complete = true if @board.colors_placed == 4
      end
      if round_complete
        @board.increment_number_of_rounds
        @codemaker.provide_feedback
        @board.display
      end
      @board.reset_positions
    end
  end

  # iterates over indices that don't match winning code.
  # if one of computer's 4 guessed colors is included in winning_code, 
  # only use winning code colors to guess until respective index equals the index of winning_code
  # else guess from all available colors
  def computer_break_code
    computer_guess = @codemaker.computer_generate_colors
    puts 'initial computer_guess: '
    puts ''
    @board.positions = computer_guess
    @board.display
    puts ''
    i = 0
    until computer_guess == @codemaker.winning_code
      computer_guess.each_with_index do |guess, index|
        until computer_guess[index] == @codemaker.winning_code[index]
          if @codemaker.winning_code.include?(guess)
            computer_guess[index] = @codemaker.winning_code[(rand * 4).floor]
          else
            computer_guess[index] = @codemaker.colors[(rand * 6).floor]
          end
          print "computer guess for position #{index + 1}: "
          if computer_guess[index] == @codemaker.winning_code[index]
            puts computer_guess[index].to_s.colorize(:background => computer_guess[index].to_sym, :color => :light_white) + " **correct**"
          else
            puts computer_guess[index].to_s.colorize(:background => computer_guess[index].to_sym, :color => :light_white)
          end
          i += 1
        end
      end
    end
    puts ''
    puts 'computer guessed correctly in #{i} rounds: '
    puts ''
    @board.display
    Game.prompt_to_play_again
  end
end
