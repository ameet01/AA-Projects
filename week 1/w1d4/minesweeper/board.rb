require_relative 'tile'

class Board
  attr_accessor :grid

  def initialize
    @grid = Array.new(9) { Array.new(9) }
    populate
    #render
    fill_with_bombs
    populate_bomb_count
  end

  def [](pos)
    x, y = pos
    @grid[x][y]
  end

  def []=(pos, tile)
    x, y = pos
    @grid[x][y] = tile
  end

  def populate
    (0...@grid.length).each do |i|
      (0...@grid.length).each do |j|
        @grid[i][j] = Tile.new(self, [i,j])
      end
    end

  end

  def populate_bomb_count
    (0...@grid.length).each do |i|
      (0...@grid.length).each do |j|
        @grid[i][j].value = @grid[i][j].neighbor_bomb_count
      end
    end
  end

  def fill_with_bombs
    array = []
    until array.length == 27
      x = rand(9)
      y = rand(9)
      array << [x, y] if !array.include?([x, y])
    end
    array.each do |i|
      self[i].bombed = true
    end
  end

  def render
    @grid.each do |i|
      array = i.map do |tile|
        t = :o
        if tile.flagged == true
          t = :F
        elsif tile.revealed
          t = tile.value
        end
        t
      end
      p array
    end
  end
end
