class Game
  #used for purpose of colorizing chosen colors each round.
  @@color_choices = [] 

  def initialize(codemaker, board)
    @codemaker = codemaker
    @board = board
    @game_over = false
    @board = Board.new([], [])
    @codemaker = CodeMaker.new(["red", "green", "magenta", "yellow", "blue", "black"])
    @codemaker.generate_colors
    break_code
  end
  
  #called in @board.display
  def self.color_choices
    @@color_choices
  end

  def show_rules
    puts <<-HEREDOC

    Welcome to Mastermind!

  # Computer has generated a sequence of 4 different colors at four positions.

  # Colors do not repeat. Only enter a color once per round.

  # Try to match your colors to the computer's generated code.

  # You have 12 rounds to solve the puzzle.

  # Winning code will revealed upon playing 12 rounds or solving the puzzle, whichever comes first.

Indicator symbols will appear on the left as you play:

      #{"@".colorize(:background => :light_red, :color => :light_white)} = a chosen color exists in code and is in correct position

      #{"@".colorize(:background => :white, :color => :light_black)} = a chosen color exists in code but is in wrong position

   Good luck!
    HEREDOC

    show_color_choices
  end

  def show_color_choices
    puts <<-HEREDOC

                      #{"red".colorize(:background => :red, :color => :light_white)} #{"green".colorize(:background => :green, :color => :light_white)} #{"magenta".colorize(:background => :magenta, :color => :light_white)}
    Available colors:
                      #{"yellow".colorize(:background => :yellow, :color => :light_white)} #{"blue".colorize(:background => :blue, :color => :light_white)} #{"black".colorize(:background => :black, :color => :light_white)}
  
    HEREDOC
  end

  def break_code
    #after four colors are placed, increment @number_of_rounds by 1. 
    #display board with positions updated to show colors
    show_rules
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
    @board.number_of_rounds = 0
    reset_positions
    @codemaker.generate_colors
    break_code
  end
end