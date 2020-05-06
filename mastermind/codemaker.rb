class CodeMaker
  attr_accessor :colors, :winning_code
  
  def initialize(colors)
    @colors = colors
    @winning_code = []
  end

  def computer_generate_colors
    winning_code = []
    random_nums = []
    #prevent duplicates. only push to winning_code if color not present. ensure there are 4 colors randomly selected
    until random_nums.count == 4
      random_num = (rand * 5).floor
      # print "#{random_num} "
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

  def human_generate_colors
    puts "please select 4 of the following colors for the computer to guess:"
    @colors.each { |color| puts "#{color}".colorize(:color => :light_white, :background => color.to_sym); puts "" }
    i = 0
    until @winning_code.count == 4
      print "enter color at position #{i + 1}: "
      selection = gets.chomp.downcase
      @winning_code[i] = selection
      i += 1
    end
    puts "the colors you chose for the computer to guess are:"
    @winning_code.each { |color| puts "#{color}".colorize(:color => :light_white, :background => color.to_sym); puts "" }
  end
end