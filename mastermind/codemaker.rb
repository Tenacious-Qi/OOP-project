class CodeMaker
  attr_accessor :colors, :winning_code
  
  def initialize(colors, board)
    @board = board
    @colors = colors
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
  
end