require 'colorize'

class Board
  attr_accessor :positions, :indicators, :colors_placed

  def initialize(positions, indicators)
    @positions = positions
    @indicators = indicators
    @colors_placed = 0
  end
  
  
  def display

    puts <<-HEREDOC

                          #{indicators[1]} #{indicators[2]}       
       #{positions[1]}  #{positions[2]}  #{positions[3]}  #{positions[4]}
                          #{indicators[3]} #{indicators[4]}

    HEREDOC
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
    puts "feedback"
  end

end

class Game

  def initialize(codemaker, board, round_controller)
    @codemaker = codemaker
    @board = board
    @round_controller = round_controller
  end



  def generate_colors
    @codemaker.generate_colors
  end

  def guess
    #after four colors are placed, increment @number_of_rounds by 1. 
    #display board with positions updated to show colors
    
    puts "make a guess"
    color = gets.chomp.downcase
    @board.positions[1] = color
    @board.display
    color == @codemaker.winning_code[0] ? "Yes" : "No"
    @round_controller.increment_number_of_rounds
    @board.colors_placed += 1
  end

  def feedback

  end
end

class RoundController
  def initialize
    @number_of_rounds = 0
  end

  def increment_number_of_rounds
    @number_of_rounds += 1
  end

  def number_of_rounds
    @number_of_rounds
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

@round_controller = RoundController.new
@board = Board.new({1=>"[ ]", 2=>"[ ]", 3=>"[ ]", 4=>"[ ]"}, {1=>"@", 2=>"@", 3=> "@", 4=>"@"})
# @codemaker = CodeMaker.new(["placeholder", "red", "green", "purple", "yellow", "orange", "brown"])
@game = Game.new(CodeMaker.new(["placeholder", "red", "green", "purple", "yellow", "orange", "brown"]), @board, @round_controller)
@game.generate_colors
