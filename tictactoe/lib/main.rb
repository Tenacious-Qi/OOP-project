# frozen_string_literal: true

require_relative 'board.rb'
require_relative 'player.rb'
require_relative 'game.rb'

game = Game.new
game.board.show_positions

start_new_game = proc do
  game = Game.new
  game.board.show_positions
  game.play_game
end

loop do
  game.play_game
  game.play_again ? start_new_game.call : exit
end
