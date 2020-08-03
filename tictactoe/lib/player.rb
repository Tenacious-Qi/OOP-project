# frozen_string_literal: true

# tracks pos of 'X' and 'O', contains boolean to determine winner
class Player
  attr_accessor :winner, :turns
  attr_writer :pos

  def initialize
    @pos = 0
    @winner = false
    @turns = 0
  end

  def update_position(input)
    @turns += 1
    @pos = input
  end

  def assign_winner
    @winner = true
  end
end
