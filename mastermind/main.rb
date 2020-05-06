require 'colorize'

require_relative 'board.rb'
require_relative 'codemaker.rb'
require_relative 'game.rb'

@game = Game.new(@codemaker, @board)