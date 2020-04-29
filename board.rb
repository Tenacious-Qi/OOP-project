class Board

  def initialize
    @@cells = {0=>"1", 1=>"2", 2=>"3", 3=>"4", 4=>"5", 5=>"6", 6=>"7", 7=>"8", 8=>"9"}
    show_positions
  end

  def show_positions
    puts ""
    puts "Welcome to TicTacToe! We will enter numbers to mark positions on the board."
    puts ""
    puts "Board positions: \n"
    puts ""
    puts "\t\t1   2   3\n\n\t\t4   5   6\n\n\t\t7   8   9"
    puts ""
  end

  def cells
    @@cells
  end

  def self.play(symbol, position)
    if @@cells[position - 1].match?("X") || @@cells[position - 1].match?("O")
      puts "ALERT: position taken, try again"
    else
      @@cells[position - 1] = symbol
    end
    display
  end

  def self.display
    puts "Current Game: "
    puts ""
    puts "\t\t#{@@cells[0]}   #{@@cells[1]}   #{@@cells[2]}\n\n\t\t#{@@cells[3]}   #{@@cells[4]}   #{@@cells[5]}\n\n\t\t#{@@cells[6]}   #{@@cells[7]}   #{@@cells[8]}"
    puts ""
  end
end