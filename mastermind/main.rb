require 'colorize'

class Board
  attr_accessor :positions, :indicators

  def initialize
    @positions = {1=>"[ ]", 2=>"[ ]", 3=>"[ ]", 4=>"[ ]"}
    @indicators = {1=>"@", 2=>"@", 3=> "@", 4=>"@"}
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
  attr_accessor :colors
  
  def initialize
    @@colors = ["placeholder", "red", "green", "purple", "yellow", "orange", "brown"]
    @@winning_code = []
  end

  def self.winning_code
    @@winning_code
  end

  def self.generate_colors
    # @@winning_code = []
    random_nums = []
    #prevent duplicates. only push to @@winning_code if color not present. ensure there are 4 @@colors randomly selected
    until random_nums.count == 4
      random_num = (rand * 6).floor + 1
      print "#{random_num} "
        if random_num == 1
          @@winning_code << @@colors[1]
          random_nums << random_num
        elsif random_num == 2 && !@@winning_code.include?(@@colors[2])
          @@winning_code << @@colors[2]
          random_nums << random_num
        elsif random_num == 3 && !@@winning_code.include?(@@colors[3])
          @@winning_code << @@colors[3]
          random_nums << random_num
        elsif random_num == 4 && !@@winning_code.include?(@@colors[4])
          @@winning_code << @@colors[4]
          random_nums << random_num
        elsif random_num == 5 && !@@winning_code.include?(@@colors[5])
          @@winning_code << @@colors[5]
          random_nums << random_num
        elsif random_num == 6 && !@@winning_code.include?(@@colors[6])
          @@winning_code << @@colors[6]
          random_nums << random_num
        end
    end
    @@winning_code
  end
  
  def provide_feedback
    #logic for determining how to color indicators
    puts "feedback"
  end

end

class CodeBreaker

  def guess
    #after four @@colors are placed, increment @number_of_rounds by 1. 
    #display board with positions updated to show @@colors
    Game.increment_number_of_rounds
    puts "make a guess"
    guess = gets.chomp.downcase
    guess == CodeMaker.winning_code[0] ? "Yes" : "No"
    
  end
  

end

class Game
  def initialize
    @@number_of_rounds = 0
 
  end

  def self.increment_number_of_rounds
    @@number_of_rounds += 1
  end

  def number_of_rounds
    @@number_of_rounds
  end

  def call_guess
    @codebreaker.guess
  end

  def over?
    game_over = false
    #if @number_of_rounds == 10, announce game is over and show @@winning_code
    if @@number_of_rounds == 10
      game_over = true
      puts "Game Over!"
      puts "winning code is " #show board positions with @@colors populated
      puts "play again?"
    end
    game_over
  end
end

@game = Game.new
@board = Board.new
@codemaker = CodeMaker.new
@codebreaker = CodeBreaker.new 
