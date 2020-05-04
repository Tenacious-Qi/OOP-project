require 'colorize'

class Board
  attr_accessor :positions, :indicators, :colors_placed, :number_of_rounds

  def initialize(positions, indicators)
    @positions = positions
    @indicators = indicators
    @colors_placed = 0
    @number_of_rounds = 0
  end
  
  def display(round_number)

    puts <<-HEREDOC

                                          #{indicators[1]} #{indicators[2]}       
       #{round_number}: #{positions[1]}  #{positions[2]}  #{positions[3]}  #{positions[4]}
                                          #{indicators[3]} #{indicators[4]}

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
      random_num = (rand * 6).floor + 1
      print "#{random_num} "
        case
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
          random_nums << random_num
          winning_code << colors[4]
        when random_num == 5 && !winning_code.include?(colors[5])
          winning_code << colors[5]
          random_nums << random_num
        when random_num == 6 && !winning_code.include?(colors[6])
          winning_code << colors[6]
          random_nums << random_num
        end
    end
    @winning_code = winning_code
    winning_code
  end
  
  def provide_feedback
    #logic for determining how to color indicators
    if @board.positions[1] == @winning_code[0]
      puts "first matches"
    end
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

  def guess
    round_complete = false
    #after four colors are placed, increment @number_of_rounds by 1. 
    #display board with positions updated to show colors
    i = 1
    until round_complete
      puts "make a guess at position #{i}"
      color = gets.chomp.strip.downcase
      @board.positions[i] = color
      @board.colors_placed += 1
      i += 1
      round_complete = true if @board.colors_placed == 4
    end
    if round_complete
      provide_feedback
      @board.increment_number_of_rounds
      @board.display(@board.number_of_rounds)
    end
    @board.colors_placed = 0
    @board.positions = {1=>"[ ]", 2=>"[ ]", 3=>"[ ]", 4=>"[ ]"}   
  end

  def winning_code
    @codemaker.winning_code
  end

  def provide_feedback
    puts "here is some feedback"
    if @board.positions[1] == winning_code[0]
      puts "one color has matched"
    end
  end
end

@board = Board.new({1=>"[ ]", 2=>"[ ]", 3=>"[ ]", 4=>"[ ]"}, {1=>"@", 2=>"@", 3=> "@", 4=>"@"})
@codemaker = CodeMaker.new(["placeholder", "red", "green", "purple", "yellow", "orange", "brown"])
@game = Game.new(@codemaker, @board)
