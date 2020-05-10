class Board
  attr_accessor :positions, :indicators, :colors_placed, :number_of_rounds

  def initialize(positions, indicators)
    @positions = positions
    @indicators = indicators
    @colors_placed = 0
    @number_of_rounds = 0
  end
  
  def display
    puts  "{ one: #{positions[0].colorize(:color => :light_white, :background => Game.color_choices[0])} | two: #{positions[1].colorize(:color => :light_white, :background => Game.color_choices[1])} | three: #{positions[2].colorize(:color => :light_white, :background => Game.color_choices[2])} | four: #{positions[3].colorize(:color => :light_white, :background => Game.color_choices[3])} }\n"
    puts ""
  end

  def increment_number_of_rounds
    @number_of_rounds += 1
  end

end