require_relative 'Tile'

class Board
  attr_accessor :grid

  def initialize(file)
    @grid = Board.from_file(file)
  end

  def self.from_file(file)
    puzzle = File.readlines(file).map(&:chomp)
    arr = []
    puzzle.each do |line|
      subzip = []
      line.each_char do |num|
        subzip << Tile.new(num.to_i)
      end
      arr << subzip
    end
    arr
  end

  def [](pos)
    row, col = pos
    grid[row][col]
  end


  def []=(pos, value)
    row, col = pos
    tile = grid[row][col]
    tile.value = value
  end

  def rows
    @grid.each do |array|
      arr = array.map {|n| n.value}.sort
      if arr != [1,2,3,4,5,6,7,8,9]
        return false
      end
    end
    true
  end

  def columns
    @grid.transpose.each do |array|
      arr = array.map {|n| n.value}.sort
      if arr != [1,2,3,4,5,6,7,8,9]
        return false
      end
    end
    true
  end

  def win
    rows && columns && three_by_three
  end

  def three_by_three
    top_left = []
    for i in (0..2)
      top_left << @grid[i].take(3)
    end
    mid_left = []
    for i in (3..5)
      mid_left << @grid[i].take(3)
    end
    bot_left = []
    for i in (6..8)
      bot_left << @grid[i].take(3)
    end
    top_left = top_left.flatten
    mid_left = mid_left.flatten
    bot_left = bot_left.flatten

    top_mid = []
    for i in (0..2)
      top_mid << @grid[i].slice(3..5)
    end
    mid_mid = []
    for i in (3..5)
      mid_mid << @grid[i].slice(3..5)
    end
    bot_mid = []
    for i in (6..8)
      bot_mid << @grid[i].slice(3..5)
    end
    top_mid = top_mid.flatten
    mid_mid = mid_mid.flatten
    bot_mid = bot_mid.flatten

    top_right = []
    for i in (0..2)
      top_right << @grid[i].slice(6..8)
    end
    mid_right = []
    for i in (3..5)
      mid_right << @grid[i].slice(6..8)
    end
    bot_right = []
    for i in (6..8)
      bot_right << @grid[i].slice(6..8)
    end
    top_right = top_right.flatten
    mid_right = mid_right.flatten
    bot_right = bot_right.flatten

    array = [top_left, mid_left, bot_left, top_mid, mid_mid, bot_mid, top_right, mid_right, bot_right]
    
    array.each do |array|
      arr = array.map {|n| n.value}.sort
      if arr != [1,2,3,4,5,6,7,8,9]
        return false
      end
    end
    true
  end


  def render
    @grid.each do |line|
      string = ""
      line.each do |i|
        string += i.value.to_s.colorize(:red) if i.given
        string += i.value.to_s if !i.given
      end
      puts string
    end
  end


end
