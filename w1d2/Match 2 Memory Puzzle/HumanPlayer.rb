
class HumanPlayer
  attr_accessor :board

  def add_board(board)
    @board = board
  end

  def take_turn
    position1 = ask_for_move
    x1, y1 = parse_position(position1)
    @board.grid[x1][y1].reveal
    display

    position2 = ask_for_move
    x2, y2 = parse_position(position2)
    @board.grid[x2][y2].reveal
    display

    check_match(x1, x2, y1, y2)

    display
  end

  def ask_for_move
    position = ""
    until valid_input?(position)
      puts "Enter a position:"
      position = gets.chomp
    end
    position
  end

  def check_match(x1, x2, y1, y2)
    if !(@board.grid[x1][y1].value == @board.grid[x2][y2].value)
      puts "Not a match"
      @board.grid[x1][y1].hide
      @board.grid[x2][y2].hide
    else
      puts "It's a match"
    end
  end

  def parse_position(position)
    x1, y1 = position[0].to_i, position[-1].to_i
  end

  def display
    @board.render
  end

  def valid_input?(pos)
    return false if pos.length != 2
    return false if @board.grid[pos[0].to_i][pos[-1].to_i].flipped == true
    array = [1,2,3,4,5,6,7,8,9,0].map {|i| i.to_s}
    pos.each_char do |i|
      return false if !array.include?(i)
    end
    return false if pos[0].to_i > @board.grid.length - 1 || pos[-1].to_i > @board.grid[0].length - 1
    true
  end

end
