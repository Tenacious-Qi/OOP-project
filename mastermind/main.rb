require 'colorize'

require_relative 'board.rb'
require_relative 'codemaker.rb'
require_relative 'game.rb'
require_relative 'codebreaker.rb'

game = Game.new(@codemaker, @codebreaker, @board)
