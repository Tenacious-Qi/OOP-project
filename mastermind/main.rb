require 'colorize'

class Board
  attr_accessor :positions, :indicators, :colors_placed, :number_of_rounds

  @@indicator_pegs = []

  def initialize(positions, indicators)
    @positions = positions
    @indicators = indicators
    @colors_placed = 0
    @number_of_rounds = 0
  end
  
  def display
    puts  "{ one: #{positions[0].to_s.colorize(:color => :light_white, :background => Game.color_choices[0])} | two: #{positions[1].to_s.colorize(:color => :light_white, :background => Game.color_choices[1])} | three: #{positions[2].to_s.colorize(:color => :light_white, :background => Game.color_choices[2])} | four: #{positions[3].to_s.colorize(:color => :light_white, :background => Game.color_choices[3])} }\n"
    puts
  end

  def increment_number_of_rounds
    @number_of_rounds += 1
  end

end

class CodeMaker
  attr_accessor :colors, :winning_code
  
  def initialize(colors)
    @colors = colors
    @winning_code = []
  end

  def generate_colors
    winning_code = []
    random_nums = []
    #prevent duplicates. only push to winning_code if color not present. ensure there are 4 colors randomly selected
    until random_nums.count == 4
      random_num = (rand * 5).floor
      print "#{random_num} "
        case
        when random_num == 0 && !winning_code.include?(colors[0])
          random_nums << random_num
          winning_code << colors[0]
        when random_num == 1 && !winning_code.include?(colors[1])
          random_nums << random_num
          winning_code << colors[1]
        when random_num == 2 && !winning_code.include?(colors[2])
          random_nums << random_num
          winning_code << colors[2]
        when random_num == 3 && !winning_code.include?(colors[3])
          random_nums << random_num
          winning_code << colors[3]
        when random_num == 4 && !winning_code.include?(colors[4])
          winning_code << colors[4]
          random_nums << random_num
        when random_num == 5 && !winning_code.include?(colors[5])
          winning_code << colors[5]
          random_nums << random_num
        end
    end
    @winning_code = winning_code
    winning_code
  end
end

class Game
  #used for purpose of colorizing chosen colors each round
  @@color_choices = [] 

  def initialize(codemaker, board)
    @codemaker = codemaker
    @board = board
    @game_over = false
    generate_colors
  end

  def generate_colors
    @codemaker.generate_colors
  end

  def self.color_choices
    @@color_choices
  end

  def show_message
    puts <<-HEREDOC

    Welcome to Mastermind!

  # From a selection of 6 colors, computer has generated a sequence of 4 different colors at four positions.

  # Colors do not repeat. Only enter a color once per round.

  # Try to match your colors to the computer's generated code.

  # You have 12 rounds to solve the puzzle.

  # Code will revealed upon playing 12 rounds or solving the puzzle, whichever comes first.

  # Good luck!

   #{"@".colorize(:background => :light_red, :color => :light_white)} = a chosen color exists in code and is in correct position

   #{"@".colorize(:background => :white, :color => :light_black)} = a chosen color exists in code but is in wrong position


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

  def guess
    #after four colors are placed, increment @number_of_rounds by 1. 
    #display board with positions updated to show colors
    show_message
    until @board.number_of_rounds == 12
      round_complete = false
      i = 0
      until round_complete
        print "make a guess at position #{i + 1}: "
        color = gets.chomp.strip.downcase
        @@color_choices << color.to_sym
        @board.positions[i] = color
        @board.colors_placed += 1
        i += 1
        round_complete = true if @board.colors_placed == 4
      end
      if round_complete
        @board.increment_number_of_rounds
        provide_feedback
        @board.display
      end
      reset_positions
    end
    if @board.number_of_rounds == 12
      @board.number_of_rounds = 0
      puts "Game over: winning code is #{@codemaker.winning_code}"
    end
    #prompt to play again, reset stuff if yes, else exit
  end

  def winning_code
    @codemaker.winning_code
  end

  def reset_positions
    @board.colors_placed = 0
    @board.positions = []
    #reset indicators
    @board.indicators = []
    @@color_choices = []
  end

  def provide_feedback
    puts "\nresult of round #{@board.number_of_rounds}:"
    puts ""

    indicator_color_only = "@".colorize(:background => :white, :color => :light_black)
    indicator_color_and_position = "@".colorize(:background => :light_red, :color => :light_white)

    exact_matches = @board.positions.select.each_with_index { |guess, index| guess == @codemaker.winning_code[index] }
    partial_matches = @board.positions.select.each_with_index { |guess, index| @codemaker.winning_code.include?(guess) && @codemaker.winning_code[index] != guess }
    if exact_matches.count == 4
      puts "You win! Your code matched winning code of #{winning_code}"
      puts ""
      exit
    end 

    1.upto(exact_matches.count) do
      @board.indicators << "@".colorize(:background => :light_red, :color => :light_white)
    end

    1.upto(partial_matches.count) do
      @board.indicators << "@".colorize(:background => :light_white, :color => :light_black)
    end

    @board.indicators.each { |indicator| print "#{indicator}  "}

  end
end

@board = Board.new([], [])
@codemaker = CodeMaker.new(["red", "green", "magenta", "yellow", "blue", "black"])
@game = Game.new(@codemaker, @board)