require './lib/game.rb'
require './lib/board.rb'
require './lib/player.rb'

describe Game do
  subject(:game) { Game.new }
  subject(:board) { Board.new }

  describe '#over?' do
    it 'returns false unless there is a winner' do
      expect(game.over?).to be false
    end

    it 'is over when p1 wins' do
      game.p1.winner = true
      expect(game.over?).to be true
    end

    it 'is over when p2 wins' do
      game.p2.winner = true
      expect(game.over?).to be true
    end
    
    it 'is over when first player goes 5 times' do
      game.p1.turns = 5
      expect(game.over?).to be true
    end
  end

  describe '#three_x?' do
    it 'returns false unless there are three X in a sequence' do
    # initially there are no X on the board
    expect(game.three_x?).to be false
    end

    it 'returns true if there are three X in a sequence' do
    3.times { |n| game.board.cells[n] = 'X' }
    expect(game.three_x?).to be true
    end
  end

  describe '#three_o?' do
    it 'returns false unless there are three O in a sequence' do
    # initially there are no X on the board
    expect(game.three_o?).to be false
    end

    it 'returns true if there are three X in a sequence' do
    3.times { |n| game.board.cells[n] = 'O' }
    expect(game.three_o?).to be true
    end
  end

  describe '#assign_winner' do
    it 'assigns p1 as the winner when p1 has three in a sequence' do
      3.times { |n| game.board.cells[n] = 'X' }
      p game.board.cells
      game.assign_winner
      expect(game.p1.winner).to be true
    end

    it 'assigns p2 as the winner when p2 has three in a sequence' do
      3.times { |n| game.board.cells[n] = 'O' }
      p game.board.cells
      game.assign_winner
      expect(game.p2.winner).to be true
    end
  end

  describe '#pos_taken?' do
    it 'returns false unless position is X or O' do
      # positions are all initially integers
      expect(game.pos_taken?(1)).to be false
    end

    it 'returns true if position is X or O' do
      game.board.cells[0] = 'X'
      # called with 1 because method subtracts 1 from position to account for input
      expect(game.pos_taken?(1)).to be true
    end
  end

  describe '#declare_winner' do
    it 'declares p1 the winner if they are assigned as the game winner' do
      game.p1.winner = true
      game.declare_winner
      expect(Game).to receive(:puts).once.with('Player 1 wins!')
    end
  end
end
