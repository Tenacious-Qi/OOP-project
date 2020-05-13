class Board

  attr_accessor :positions, :indicators, :colors_placed, :number_of_rounds
  
  def initialize(positions, indicators)
    @positions = positions
    @indicators = indicators
    @colors_placed = 0
    @number_of_rounds = 0
  end
  
  def display
    @positions.each_with_index { |position, index| print "P#{index + 1}: #{position.colorize(:background => position.to_sym, :color => :light_white)}  " }
    puts ""
  end

  def increment_number_of_rounds
    @number_of_rounds += 1
  end

  def reset_positions
    @colors_placed = 0
    @positions = []
    @indicators = []
  end
end
