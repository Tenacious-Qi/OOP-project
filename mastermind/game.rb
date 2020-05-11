class Game

  def initialize(codemaker, board)
    @codemaker = codemaker
    @board = board
    @board = Board.new([], [])
    @codemaker = CodeMaker.new(["red", "green", "magenta", "yellow", "blue", "black"], @board)
    make_code_or_break_code
  end

  def make_code_or_break_code
    show_message
    puts "Would you like to be the codemaker or the codebreaker?"
    puts ""
    print "# enter 'B' to break the code, or 'M' to make the code: "
    choice = gets.chomp.upcase
    until choice == "B" || choice == "M"
      puts "# please enter B or M:"
      choice = gets.chomp.upcase
      puts ""
    end
    if choice == "B"
      @codemaker.computer_generate_colors
      @codemaker.show_colors
      human_break_code
    elsif choice == "M"
      @codemaker.human_generate_colors
      computer_break_code
    end
  end

  def show_message
    puts <<-HEREDOC

      Welcome to Mastermind!

  # Computer has generated a code of 4 colors at 4 respective positions.

  # Try to match your colors to the computer's generated code.

  # Colors do not repeat. Only enter a color once per round.

  # You have 12 rounds to solve the puzzle.

  # The winning code will be revealed upon playing 12 rounds or solving the puzzle, whichever comes first.

Indicator symbols will appear on the left as you play, showing you how good your guess was:

      #{"@".colorize(:background => :light_red, :color => :light_white)} = a chosen color exists in code and is in correct position

      #{"@".colorize(:background => :white, :color => :light_black)} = a chosen color exists in code but is in wrong position

   Good luck!

    HEREDOC

  end
  
  def human_break_code
    #after four colors are placed, increment @number_of_rounds by 1. 
    #display board with positions updated to show colors
    until @board.number_of_rounds == 12
      round_complete = false
      i = 0
      until round_complete
        # puts ""
        print "\nmake a guess at position #{i + 1}: "
        color = gets.chomp.strip.downcase
        until color.match?(/red|green|magenta|yellow|blue|black/) && !@board.positions.include?(color)
          puts "\n## entry must match available colors (colors do not repeat)"
          print "\nPlease enter a valid color for position #{i + 1}: "
          color = gets.chomp.strip.downcase
        end
        if color.match?(/red|green|magenta|yellow|blue|black/)
          @board.positions[i] = color
          @board.colors_placed += 1
          i += 1
        end
        round_complete = true if @board.colors_placed == 4
      end
      if round_complete
        @board.increment_number_of_rounds
        provide_feedback
        @board.display
      end
      reset_positions
    end
  end

  # iterates over indices that don't match winning code.
  # if one of computer's 4 guessed colors is included in winning_code, 
  # only use winning code colors to guess until respective index equals the index of winning_code
  # else guess from all available colors
  def computer_break_code
    computer_guess = @codemaker.computer_generate_colors
    puts "initial computer_guess: "
    puts ""
    @board.positions = computer_guess
    @board.display
    puts ""
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
            puts "#{computer_guess[index]}".colorize(:background => computer_guess[index].to_sym, :color => :light_white) + " **correct**"
          else
            puts "#{computer_guess[index]}".colorize(:background => computer_guess[index].to_sym, :color => :light_white)
          end
          i += 1
        end
      end
    end

    puts ""
    puts "computer guessed correctly in #{i} rounds: "
    puts ""

    @board.display
    prompt_to_play_again
  end

  def provide_feedback
    puts "\nresult of round #{@board.number_of_rounds}:"
    puts ""
    exact_matches = @board.positions.select.each_with_index { |guess, index| guess == @codemaker.winning_code[index] }
    partial_matches = @board.positions.select.each_with_index { |guess, index| @codemaker.winning_code.include?(guess) && @codemaker.winning_code[index] != guess }

    #push appropriate indicator colors into an array and then print each one.
    0.upto(exact_matches.count - 1) do
      @board.indicators << "@".colorize(:background => :light_red, :color => :light_white)
    end
    0.upto(partial_matches.count - 1) do
      @board.indicators << "@".colorize(:background => :light_white, :color => :light_black)
    end
    @board.indicators.each { |indicator| print "#{indicator}  "}

    if exact_matches.count == 4
      print "You win! "
      @board.display
      prompt_to_play_again
    end 
    if @board.number_of_rounds == 12
      @board.number_of_rounds = 0
      puts "# Game over."
      print "# Winning code: "
      @board.display
      prompt_to_play_again
    end
  end

  def reset_positions
    @board.colors_placed = 0
    @board.positions = []
    @board.indicators = []
  end

  def prompt_to_play_again
    puts ""
    print "# Play Again? Enter Y or N: "
    answer = gets.chomp.upcase
    until answer == "Y" || answer == "N"
      puts "# please enter Y or N:"
      answer = gets.chomp.upcase
    end
    answer == "Y" ? start_new_game : exit
  end

  def start_new_game
    @game = Game.new(@codemaker, @board)
  end
end