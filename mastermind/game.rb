class Game
  
  def initialize(codemaker, codebreaker, board)
    @codemaker = codemaker
    @codebreaker = codebreaker
    @board = board
    @board = Board.new([], [])
    @codemaker = CodeMaker.new(["red", "green", "magenta", "yellow", "blue", "black"], @board, @codebreaker)
    @codebreaker = CodeBreaker.new(@board, @codemaker)
    make_code_or_break_code
  end

  def make_code_or_break_code
    show_message
    puts "Would you like to be the codemaker or the codebreaker?"
    puts ""
    print "# enter 'B' to break the code, or 'M' to make the code: "
    choice = gets.chomp.upcase
    until choice == "B" || choice == "M"
      puts "# please enter B or M:"
      choice = gets.chomp.upcase
      puts ""
    end
    if choice == "B"
      @codemaker.computer_generate_colors
      @codemaker.show_colors
      @codebreaker.human_break_code
    elsif choice == "M"
      @codemaker.human_generate_colors
      @codebreaker.computer_break_code
    end
  end

  def show_message
    puts <<-HEREDOC

      Welcome to Mastermind!

  # Computer has generated a code of 4 colors at 4 respective positions.

  # Try to match your colors to the computer's generated code.

  # Colors do not repeat. Only enter a color once per round.

  # You have 12 rounds to solve the puzzle.

  # The winning code will be revealed upon playing 12 rounds or solving the puzzle, whichever comes first.

Indicator symbols will appear on the left as you play, showing you how good your guess was:

      #{"@".colorize(:background => :light_red, :color => :light_white)} = a chosen color exists in code and is in correct position

      #{"@".colorize(:background => :white, :color => :light_black)} = a chosen color exists in code but is in wrong position

   Good luck!

    HEREDOC

  end

  def self.prompt_to_play_again
    puts ""
    print "# Play Again? Enter Y or N: "
    answer = gets.chomp.upcase
    until answer == "Y" || answer == "N"
      puts "# please enter Y or N:"
      answer = gets.chomp.upcase
    end
    answer == "Y" ? start_new_game : exit
  end

  def self.start_new_game
    game = Game.new(@codemaker, @codebreaker, @board)
  end
end