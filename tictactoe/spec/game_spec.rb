require './lib/game.rb'
require './lib/board.rb'
require './lib/player.rb'

describe Game do
  subject(:game) { described_class.new }
  subject(:board) { Board.new }

  describe '#p1_go' do
    context 'when board position is not an X or O' do
      it 'marks X on that board position' do
        allow(game).to receive(:verify_p1_input).and_return(game.p1.pos = 1)
        allow(game.board).to receive(:display)
        allow(board).to receive(:cells).and_return('X')
        expect(board.cells[game.p1.pos - 1]).to eq('X')
      end
    end

    it 'increases p1 turns by 1' do
      game.p1.turns = 0
      allow(game).to receive(:verify_p1_input).and_return(game.p1.pos = 1)
      allow(game.board).to receive(:display)
      game.p1_go
      expect(game.p1.turns).to eq(1)
    end
  end

  # expect(player1).to receive(:update_position).with(1) #suggestion from rlmoser
  describe '#verify_p1_input' do
    context 'when user input is an integer between 1 and 9' do
      user_input = '1'
      
      before do
        allow(game).to receive(:puts)
        allow(game).to receive(:gets).and_return(user_input)
      end

      it 'assigns the input to @p1.pos' do
        game.verify_p1_input
        expect(game.p1.pos).to eq(user_input.to_i)
      end
    end

    context 'when user input is not an integer between 1 and 9' do

      user_input = 'asdf'

      before do
        expect(game).to receive(:puts).once.with('Player 1, please choose a position to mark:')
      end

      it 'requests a new input until input is valid' do
        expect(game).to receive(:gets).and_return(user_input)
        expect(game).to receive(:puts).once.with('Please enter a number between 1 and 9')
        new_input = '1'
        allow(game).to receive(:gets).and_return(new_input)
        game.verify_p1_input
        expect(game.p1.pos).to eq(1)
      end
    end
  end

  describe '#assign_winner' do
    it 'assigns p1 as the winner when p1 has three in a sequence' do
      3.times { |n| game.board.cells[n] = 'X' }
      game.assign_winner
      expect(game.p1.winner).to be true
    end

    it 'assigns p2 as the winner when p2 has three in a sequence' do
      3.times { |n| game.board.cells[n] = 'O' }
      game.assign_winner
      expect(game.p2.winner).to be true
    end
  end

  # technically an outgoing query (can safely ignore)
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

  # outgoing query (can safely ignore)
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

  # outgoing query (can safely ignore)
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

  # outgoing query (can safely ignore)
  describe '#declare_winner' do
    context 'when p1 is winner' do
      it 'declares p1 the winner' do
        game.p1.winner = true
        allow(game).to receive(:prompt_to_play_again)
        expect{ game.declare_winner }.to output("Player 1 wins!\n").to_stdout
        allow(game).to receive(:puts)
        game.declare_winner
      end
    end
    context 'when p2 is winner' do
      it 'declares p2 the winner' do
        game.p2.winner = true
        allow(game).to receive(:prompt_to_play_again)
        expect{ game.declare_winner }.to output("Player 2 wins!\n").to_stdout
        allow(game).to receive(:puts)
        game.declare_winner
      end
    end

    context 'when game is over' do
      it 'game prompts to play again' do
        game.p1.winner = true
        expect(game).to receive(:prompt_to_play_again)
        allow(game).to receive(:puts)
        game.declare_winner
      end
    end
  end
end
