# frozen_string_literal: true

require_relative 'board.rb'
require_relative 'player.rb'
require_relative 'game.rb'

game = Game.new
game.board.show_positions

loop do
  game.play_game
  if game.play_again
    game = Game.new
    game.board.show_positions
    game.play_game
  else
    exit
  end
end
