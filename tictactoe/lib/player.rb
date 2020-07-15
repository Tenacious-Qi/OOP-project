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
end
