require './lib/game.rb'
require './lib/board.rb'
require './lib/player.rb'

describe Game do

  subject(:game) { described_class.new }

  describe '#p1_turn' do

    selected_position = '1'

    before do
      allow(game).to receive(:puts)
      allow(game.board).to receive(:display)
      allow(game).to receive(:gets).and_return(selected_position)
    end

    context 'when selected position is available' do
      it 'tells @board to mark that position' do
        expect(game.board).to receive(:mark).with(selected_position.to_i - 1, 'X')
        game.p1_turn
      end
    end

    it 'tells @p1 to increments its number of turns' do
      expect(game.p1).to receive(:increment_turns)
      game.p1_turn
    end
  end

  describe '#assign_winner' do

    context 'when there are three X on the board' do
  
      before do
        allow(game.board).to receive(:three_x?).and_return(true)
      end
  
      it 'tells @p1 to assign itself the winner of the game' do
        expect(game.p1).to receive(:assign_winner)
        game.assign_winner
      end
    end

    context 'when there are three O on the board' do

      before do
        allow(game.board).to receive(:three_o?).and_return(true)
      end

      it 'tells @p2 to assign itself the winner of the game' do
        expect(game.p2).to receive(:assign_winner)
        game.assign_winner
      end
    end
  end
end
