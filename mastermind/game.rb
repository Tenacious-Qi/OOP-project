class Game
  #used for purpose of colorizing chosen colors each round.
  @@color_choices = [] 

  def initialize(codemaker, board)
    @codemaker = codemaker
    @board = board
    @board = Board.new([], [])
    @codemaker = CodeMaker.new(["red", "green", "magenta", "yellow", "blue", "black"])
    make_code_or_break_code
  end

  def make_code_or_break_code
    show_message
    puts "Would you like to be the codemaker or the codebreaker?"
    puts ""
    print "enter 'B' to break the code, or 'M' to make the code: "
    choice = gets.chomp.upcase
    until choice == "B" || choice == "M"
      puts "please enter B or M:"
      choice = gets.chomp.upcase
    end
    if choice == "B"
      @codemaker.computer_generate_colors
      show_color_choices
      human_break_code
    elsif choice == "M"
      @codemaker.human_generate_colors
      computer_break_code
    end
  end
  
  #called in @board.display
  def self.color_choices
    @@color_choices
  end

  def show_message
    puts <<-HEREDOC

      #{"Welcome to Mastermind!".colorize(:cyan)}

  # #{"Computer has generated a sequence of 4 different colors at 4 positions.".colorize(:red)}

  # #{"Colors do not repeat. Only enter a color once per round.".colorize(:red)}

  # #{"Try to match your colors to the computer's generated code.".colorize(:red)}

  # #{"You have 12 rounds to solve the puzzle.".colorize(:red)}

  # #{"Code will be revealed upon playing 12 rounds or solving the puzzle, whichever comes first.".colorize(:red)}

#{"Indicator symbols will appear on the left as you play:".colorize(:cyan)}

      #{"@".colorize(:background => :light_red, :color => :light_white)} = a chosen color exists in code and is in correct position

      #{"@".colorize(:background => :white, :color => :light_black)} = a chosen color exists in code but is in wrong position

   #{"Good luck!".colorize(:cyan)}

    HEREDOC

  end

  def show_color_choices
    puts <<-HEREDOC

                      #{"red".colorize(:background => :red, :color => :light_white)} #{"green".colorize(:background => :green, :color => :light_white)} #{"magenta".colorize(:background => :magenta, :color => :light_white)}
    Available colors:
                      #{"yellow".colorize(:background => :yellow, :color => :light_white)} #{"blue".colorize(:background => :blue, :color => :light_white)} #{"black".colorize(:background => :black, :color => :light_white)}
  
    HEREDOC
  end
  
  def human_break_code
    #after four colors are placed, increment @number_of_rounds by 1. 
    #display board with positions updated to show colors
    until @board.number_of_rounds == 12
      round_complete = false
      i = 0
      until round_complete
        print "make a guess at position #{i + 1}: "
        color = gets.chomp.strip.downcase
        until color.match?(/red|green|magenta|yellow|blue|black/) && !@board.positions.include?(color)
          puts "\n## entry must match available colors (colors do not repeat)"
          print "\nPlease enter a valid color for position #{i + 1}: "
          color = gets.chomp.strip.downcase
        end
        if color.match?(/red|green|magenta|yellow|blue|black/)
          @@color_choices << color.to_sym
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
    i = 0
    puts "initial computer_guess: #{computer_guess}"
    puts ""
    until computer_guess == @codemaker.winning_code
      computer_guess.each_with_index do |guess, index|
        until computer_guess[index] == @codemaker.winning_code[index]
          if @codemaker.winning_code.include?(guess)
            computer_guess[index] = @codemaker.winning_code[(rand * 4).floor]
          else
            computer_guess[index] = @codemaker.colors[(rand * 6).floor]
          end
          puts "computer guess #{i + 1} for position #{index + 1}: #{computer_guess[index]}"
          i += 1
        end
      end
    end
    puts ""
    puts "computer made correct guess of #{computer_guess} after #{i} guesses"
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
      puts "You win! Your code matched winning code of #{@codemaker.winning_code}"
      prompt_to_play_again
    end 
    if @board.number_of_rounds == 12
      @board.number_of_rounds = 0
      puts "Game over: winning code is #{@codemaker.winning_code}\n"
      prompt_to_play_again
    end
  end

  def reset_positions
    @board.colors_placed = 0
    @board.positions = []
    @board.indicators = []
    @@color_choices = []
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

  def start_new_game
    @game = Game.new(@codemaker, @board)
  end
end