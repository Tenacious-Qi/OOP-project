require './lib/board.rb'

describe Board do
  subject(:board) { described_class.new }

  describe '#mark' do
    context 'when it\'s player 1\'s turn' do
      p1_input = 1

      before do
        board.mark(p1_input - 1, 'X')
      end

      it 'updates the respective @cells position with X' do
        expect(board.cells).to eq(['X', 2, 3, 4, 5, 6, 7, 8, 9])
      end
    end

    context 'when it\'s player 2\'s turn' do
      p2_input = 4

      before do
        board.mark(p2_input - 1, 'O')
      end

      it 'updates the respective @cells position with O' do
        expect(board.cells).to eq([1, 2, 3, 'O', 5, 6, 7, 8, 9])
      end
    end
  end

  describe '#pos_taken?' do
    context 'when position is taken' do
      it 'returns true' do
        board.instance_variable_set(:@cells, [1, 2, 3, 'O', 5, 6, 7, 8, 9])
        expect(board.pos_taken?(4)).to be true
      end
    end

    context 'when position is NOT taken' do
      it 'returns false' do
        board.instance_variable_set(:@cells, [1, 2, 3, 'O', 5, 6, 7, 8, 9])
        expect(board.pos_taken?(0)).to be false
      end
    end
  end

  describe '#three_x?' do
    context 'when there are three X in a line on board' do
      it 'returns true' do
        board.instance_variable_set(:@cells, ['X', 'X', 'X', 4, 5, 6, 7, 8, 9])
        expect(board.three_x?).to be true
      end
    end

    context 'when there are NOT three X in a line on board' do
      it 'returns false' do
        board.instance_variable_set(:@cells, ['X', 2, 'O', 4, 5, 6, 7, 8, 9])
        expect(board.three_o?).to be false
      end
    end
  end

  describe '#three_o?' do
    context 'when there are three O in a line on board' do
      it 'returns true' do
        board.instance_variable_set(:@cells, ['O', 'O', 'O', 4, 5, 6, 7, 8, 9])
        expect(board.three_o?).to be true
      end
    end

    context 'when there are NOT three O in a line on board' do
      it 'returns false' do
        board.instance_variable_set(:@cells, ['X', 2, 'O', 4, 5, 6, 7, 8, 9])
        expect(board.three_o?).to be false
      end
    end
  end
end
