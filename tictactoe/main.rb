#!/usr/bin/ruby
require_relative 'board.rb'
require_relative 'player.rb'
require_relative 'game.rb'

def check_if_player_one_wins
  win = ["X", "X", "X"] #@board.cells.values_at(0,1,2)
  case
  #rows
  when @board.cells.values_at(0,1,2) == win then @player1.winner = true
  when @board.cells.values_at(3,4,5) == win then @player1.winner = true
  when @board.cells.values_at(6,7,8) == win then @player1.winner = true
  #columns
  when @board.cells.values_at(0,3,6) == win then @player1.winner = true
  when @board.cells.values_at(1,4,7) == win then @player1.winner = true
  when @board.cells.values_at(2,5,8) == win then @player1.winner = true
  #diagonals
  when @board.cells.values_at(0,4,8) == win then @player1.winner = true
  when @board.cells.values_at(2,4,6) == win then @player1.winner = true
  end
end

def check_if_player_two_wins
  win = ["O", "O", "O"]
  case
  #rows
  when @board.cells.values_at(0,1,2) == win then @player2.winner = true
  when @board.cells.values_at(3,4,5) == win then @player2.winner = true
  when @board.cells.values_at(6,7,8) == win then @player2.winner = true
  #columns
  when @board.cells.values_at(0,3,6) == win then @player2.winner = true
  when @board.cells.values_at(1,4,7) == win then @player2.winner = true
  when @board.cells.values_at(2,5,8) == win then @player2.winner = true
  #diagonals
  when @board.cells.values_at(0,4,8) == win then @player2.winner = true
  when @board.cells.values_at(2,4,6) == win then @player2.winner = true
  end
end

@game = Game.new
@game.start_new_game