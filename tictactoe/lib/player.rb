# frozen_string_literal: true

# tracks pos of 'X' and 'O', contains boolean to determine winner
class Player
  attr_accessor :winner, :turns, :pos, :symbol

  def initialize(symbol)
    @symbol = symbol
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
