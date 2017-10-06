require_relative 'board'
require_relative 'HumanPlayer'
require_relative 'card'
require_relative 'AiPlayer'

class Game
  attr_accessor :board, :player

  def initialize(player, board = Board.new)
    @board = board
    @player = player
    @player.add_board(@board)
  end

  def play
    until over?
      player.take_turn
    end
    puts "You won!"
  end

  def over?
    @board.grid.each do |array|
      array.each do |card|
        return false if card.flipped == false
      end
    end
    true
  end

end

game = Game.new(AiPlayer.new)

game.play
