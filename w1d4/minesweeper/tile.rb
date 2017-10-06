require_relative 'board'

class Tile
  attr_accessor :revealed, :value, :flagged, :bombed, :board, :x_position, :y_position

  def initialize(board,position)
    @revealed = false
    @board = board
    @bombed = false
    @flagged = false
    @x_position = position[0]
    @y_position = position[1]
    #@value = neighbor_bomb_count
    #@value = 0
  end

  def neighbor_bomb_count
    @neighbors.select{|neighbor| neighbor.bombed == true}.count
  end



  def reveal
    @revealed = true
  end

  def flag
    @flagged = true
  end

  #return array of neighboring tile objects
  def neighbors
    neighboring = []
    neighboring << @board.grid[@x_position][@y_position+1] unless [@x_position, @y_position+1].any? { |i| !i.between?(0, 8) }
    neighboring << @board.grid[@x_position][@y_position-1] unless [@x_position, @y_position-1].any? { |i| !i.between?(0, 8) }
    neighboring << @board.grid[@x_position+1][@y_position+1] unless [@x_position+1, @y_position+1].any? { |i| !i.between?(0, 8) }
    neighboring << @board.grid[@x_position-1][@y_position+1] unless [@x_position-1, @y_position+1].any? { |i| !i.between?(0, 8) }
    neighboring << @board.grid[@x_position+1][@y_position-1] unless [@x_position+1, @y_position-1].any? { |i| !i.between?(0, 8) }
    neighboring << @board.grid[@x_position-1][@y_position-1] unless [@x_position-1, @y_position-1].any? { |i| !i.between?(0, 8) }
    neighboring << @board.grid[@x_position-1][@y_position] unless [@x_position-1, @y_position].any? { |i| !i.between?(0, 8) }
    neighboring << @board.grid[@x_position+1][@y_position] unless [@x_position+1, @y_position].any? { |i| !i.between?(0, 8) }
    p neighboring
    neighboring
  end

end
