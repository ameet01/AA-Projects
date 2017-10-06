require_relative 'board'

class Game
  attr_accessor :board

  def initialize
    @board = Board.new
  end

  def play
    until over?
      board.render
      take_turn
    end
    if win?
      p 'you won'
    elsif lose?
      p 'you lose'
    end

  end

  def parse_pos(str)
    [str[0].to_i, str[2].to_i]
  end

  def take_turn
    puts "Enter position and flag?: (x,y,f)"
    input = gets.chomp
    position = parse_pos(input)
    if input[-1] == "f"
      @board[position].flag
    else
      @board[position].reveal
    end
  end

  def win?
    not_bombs = @board.grid.flatten.select{|tile| tile.bombed == false}
    not_bombs.all?{|tile| tile.revealed == true}
  end

  def lose?
    bombs = @board.grid.flatten.select{|tile| tile.bombed == true}
    bombs.any?{|tile| tile.revealed == true}
  end

  def over?
    win? || lose?
  end

end


if __FILE__ == $PROGRAM_NAME
  game = Game.new
  game.play
end
