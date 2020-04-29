class Player 
  attr_accessor :winner, :number_of_turns, :position
  attr_reader :number_of_turns

  def initialize(symbol)
    @symbol = symbol
    @winner = false
    @position = 0
    @number_of_turns = 0
  end

  def play(position)
    puts `clear`
    Board.play(@symbol, position)
    @number_of_turns += 1
  end
end