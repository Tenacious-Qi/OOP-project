# frozen_string_literal: true

require_relative 'board.rb'
require_relative 'player.rb'
require_relative 'game.rb'

game = Game.new
loop do
  game.play_game
  if game.play_again
    next_game = Game.new
    next_game.play_game
  else
    exit
  end
end
