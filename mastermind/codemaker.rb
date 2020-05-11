class CodeMaker
  
  attr_accessor :colors, :winning_code
  
  def initialize(colors, board, codebreaker)
    @colors = colors
    @board = board
    @codebreaker = codebreaker
    @winning_code = []
    @human_making_colors = false
  end

  def computer_generate_colors
    winning_code = []
    @colors.each do |color|
      until winning_code.count == 4
        random_num = (rand * 6).floor
        winning_code << @colors[random_num] unless winning_code.include?(@colors[random_num])
      end
    end
    @winning_code = winning_code unless @human_making_colors #because this method is also used when computer is codebreaker to generate its initial guess
    winning_code
  end

  def human_generate_colors
    @human_making_colors = true
    puts "please select 4 colors for the computer to guess."
    show_colors
    i = 0
    until @winning_code.count == 4
      print "\nenter color at position #{i + 1}: "
      selection = gets.chomp.downcase
      until selection.match?(/red|green|magenta|yellow|blue|black/) && !winning_code.include?(selection)
        puts "\n## entry must match available colors (colors do not repeat)"
        print "\nPlease enter a valid color for position #{i + 1}: "
        selection = gets.chomp.downcase
      end
      @winning_code[i] = selection
      @board.positions[i] = selection
      i += 1
    end
    puts "\nthe colors you chose for the computer to guess are:"
    puts ""
    @board.display
    puts ""
  end

  def show_colors
    puts ""
    puts "Available colors: "
    puts "" 
    @colors.each { |color| print "#{color}".colorize(:color => :light_white, :background => color.to_sym) + "  " }
    puts ""
  end

  def provide_feedback
    puts "\nresult of round #{@board.number_of_rounds}:"
    puts ""
    exact_matches = @board.positions.select.each_with_index { |guess, index| guess == @winning_code[index] }
    partial_matches = @board.positions.select.each_with_index { |guess, index| @winning_code.include?(guess) && @winning_code[index] != guess }

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
      puts "Game over."
      puts ""
      print "# Winning code >> "
      @board.positions = @winning_code
      @board.display
      prompt_to_play_again
    end
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
    @game = Game.new(@codemaker, @codebreaker, @board)
  end
end