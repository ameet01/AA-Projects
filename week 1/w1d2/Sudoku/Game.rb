require_relative 'Board'
require_relative 'Tile'
require 'colorize'

class Game
  attr_accessor :board

  def initialize(board)
    @board = board
  end

  def play
    @board.render
    until @board.win
      take_turn
      @board.render
      p @board.three_by_three
    end
    puts 'You won the game!'
  end

  def take_turn
    pos = ""
    until valid_move?(pos)
      puts 'Enter a move'
      pos = gets.chomp
      x = pos[0].to_i
      y = pos[-1].to_i
    end

    puts 'Enter a value'
    number = gets.chomp.to_i

    @board.grid[x][y].value = number

  end

  def valid_move?(pos)
    return false if pos == ""
    x = pos[0].to_i
    y = pos[-1].to_i
    return false if @board.grid[x][y].value > 0
    true
  end



end


game = Game.new(Board.new("sudoku1-almost.txt"))
game.play
