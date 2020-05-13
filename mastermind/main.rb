# frozen_string_literal: true

require 'colorize'
require_relative 'board.rb'
require_relative 'codemaker.rb'
require_relative 'game.rb'
require_relative 'codebreaker.rb'

Game.new(@codemaker, @codebreaker, @board)
