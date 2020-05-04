require 'colorize'

class Board
  attr_accessor :positions, :indicators, :colors_placed, :number_of_rounds

  def initialize(positions, indicators)
    @positions = positions
    @indicators = indicators
    @colors_placed = 0
    @number_of_rounds = 0
  end
  
  def display

    puts <<-HEREDOC

                                          #{indicators[0]} #{indicators[1]}       
        #{positions[0]}  #{positions[1]}  #{positions[2]}  #{positions[3]}
                                          #{indicators[2]} #{indicators[3]}

    HEREDOC
  end

  def increment_number_of_rounds
    @number_of_rounds += 1
  end

  def over?
    game_over = false
    #if @number_of_rounds == 10, announce game is over and show winning_code
    if @number_of_rounds == 10
      game_over = true
      puts "Game Over!"
      puts "winning code is " #show board positions with colors populated
      puts "play again?"
    end
    game_over
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

  def initialize(codemaker, board)
    @codemaker = codemaker
    @board = board
    generate_colors
  end

  def generate_colors
    @codemaker.generate_colors
  end

  def show_message
    puts <<-HEREDOC

    Welcome to Mastermind!

    We will play 10 rounds. Try to guess code in 10 rounds.
    Code will be revealed after 10 rounds or upon guessing correct code.

                            #{"red".red} #{"green".green} #{"purple".magenta}
    Your color choices are: 
                            #{"yellow".yellow} #{"blue".blue} #{"black".light_black}

    HEREDOC
  end

  def show_color_choices
    puts <<-HEREDOC

                            #{"red".red} #{"green".green} #{"purple".magenta}
    Your color choices are: 
                            #{"yellow".yellow} #{"blue".blue} #{"black".light_black}

    HEREDOC
  end

  def guess
    #after four colors are placed, increment @number_of_rounds by 1. 
    #display board with positions updated to show colors
    show_message
    until @board.number_of_rounds == 10
      round_complete = false
      i = 0
      until round_complete
        print "make a guess at position #{i + 1}: "
        color = gets.chomp.strip.downcase
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
    @board.number_of_rounds = 0  
  end

  def winning_code
    @codemaker.winning_code
  end

  def reset_positions
    @board.colors_placed = 0
    @board.positions = {1=>"[ ]", 2=>"[ ]", 3=>"[ ]", 4=>"[ ]"} 
  end

  def provide_feedback
    puts "\nresults of round #{@board.number_of_rounds}: \n"
    if @board.positions[0] == winning_code[0]
      puts "\none color has matched"
    end
  end
end

@board = Board.new({0=>"[ ]", 1=>"[ ]", 2=>"[ ]", 3=>"[ ]"}, {0=>"@", 1=>"@", 2=> "@", 3=>"@"})
@codemaker = CodeMaker.new(["red", "green", "purple", "yellow", "blue", "black"])
@game = Game.new(@codemaker, @board)
