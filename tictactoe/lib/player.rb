# frozen_string_literal: true

# tracks pos of 'X' and 'O', contains boolean to determine winner
class Player
  attr_accessor :winner, :turns

  def initialize
    @winner = false
    @turns = 0
  end

  def increment_turns
    @turns += 1
  end

  def assign_winner
    @winner = true
  end
end
