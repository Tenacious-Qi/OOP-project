require './lib/player.rb'
require './lib/board.rb'
require './lib/game.rb'

describe Player do
  subject(:player) { described_class.new }
  subject(:game) { Game.new }

  describe '#increment_turns' do

    context 'when player1 has a turn in game' do
      before do
        allow(game).to receive(:puts)
        allow(game).to receive(:gets).and_return('1')
        allow(game.board).to receive(:display)
        game.p1_turn
      end

      it 'increases their turns count by 1' do
        expect(game.p1.turns).to eq(1)
      end
    end
  end

  describe '#assign_winner' do
    context 'when game calls board.three_x? within #assign_winner and there are three X in a line' do
      before do
        game.board.instance_variable_set(:@cells, ['X', 'X', 'X', 4, 5, 6, 7, 8, 9])
        game.assign_winner
      end

      it 'assigns @p1 as winner' do
        expect(game.p1.winner).to be true
      end
    end

    context 'when game calls board.three_x? within #assign_winner and there are NOT three X in a line' do
      before do
        game.board.instance_variable_set(:@cells, ['X', 'O', 'X', 4, 5, 6, 7, 8, 9])
        game.assign_winner
      end

      it 'does NOT assign @p1 as winner' do
        expect(game.p1.winner).to be false
      end
    end

    context 'when game calls board.three_o? within #assign_winner and there are three O in a line' do
      before do
        game.board.instance_variable_set(:@cells, ['O', 'O', 'O', 4, 5, 6, 7, 8, 9])
        game.assign_winner
      end

      it 'assigns @p2 as winner' do
        expect(game.p2.winner).to be true
      end
    end

    context 'when game calls board.three_o? within #assign_winner and there are NOT three O in a line' do
      before do
        game.board.instance_variable_set(:@cells, ['O', 'X', 'O', 4, 5, 6, 7, 8, 9])
        game.assign_winner
      end

      it 'does NOT assign @p2 as winner' do
        expect(game.p2.winner).to be false
      end
    end
  end
end
