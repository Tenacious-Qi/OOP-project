puts ""
puts "Welcome to TicTacToe, we will play by entering commands."
puts ""

class Game

  @@winner = false
  def initialize
    @@cells = []
    @@winner = false
    puts "Board positions: \n"
    puts ""
    puts "0   1   2\n\n3   4   5\n\n6   7   8"
    puts ""
  end

  def cells
    @@cells
  end

  def winner
    @@winner
  end

  def winner=(boolean)
    @@winner = boolean
  end

  def self.play(symbol, location)
    if @@cells[location]
      puts "ALERT: location taken, try again"
    else
      @@cells[location] = symbol
    end
    puts ""
    puts "Game board: "
    puts ""
    puts "#{@@cells[0]}   #{@@cells[1]}   #{@@cells[2]}\n\n#{@@cells[3]}   #{@@cells[4]}   #{@@cells[5]}\n\n#{@@cells[6]}   #{@@cells[7]}   #{@@cells[8]}"
    puts ""
  end

end

class Player 

  def initialize(symbol)
    @symbol = symbol
    @@current_location = 0
  end

  def current_location
    @@current_location
  end

  def current_location=(new_location)
    @@current_location = new_location
  end

  def play(location)
    Game.play(@symbol, location)
  end
end

@game = Game.new
puts "Player 1, please choose 'X' or 'O', Player 2 will be opposite symbol"
symbol = gets.chomp.upcase
@player1 = Player.new(symbol)
symbol.upcase == 'X' ? @player2 = Player.new('O') : @player2 = Player.new('X')

while @game.winner == false
  puts "Player 1, please choose a location to mark: "
  @player1.current_location = gets.chomp.to_i
  @player1.play(@player1.current_location)
  if @game.cells[0..2] == ["X", "X", "X"]
    @game.winner = true
    puts "Player 1 wins"
    break
  end
  puts "Player 2, please choose a location to mark: "
  @player2.current_location = gets.chomp.to_i
  @player2.play(@player2.current_location)

end

# puts "Board positions: \n"
# puts ""
# puts "0   1   2\n\n3   4   5\n\n6   7   8"

