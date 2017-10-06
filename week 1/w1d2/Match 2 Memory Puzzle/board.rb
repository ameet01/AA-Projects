class Board
  attr_accessor :grid

  def initialize
    @grid = Array.new(5) { Array.new(6) }
    populate
  end

  def populate
    cards = []
    (1..15).each do |i|
      card = Card.new(i)
      cards << card
      cards << card.dup
    end
    until is_full?
      i, j = rand(0..4), rand(0..5)
      o, l = rand(0..4), rand(0..5)
      if !grid[i][j] && !grid[o][l]
        @grid[i][j] = cards.pop
        @grid[o][l] = cards.pop
      end
    end
  end

  def is_full?
    @grid.each do |i|
      if i.include?(nil)
        return false
      end
    end
    true
  end

  def render
    result = []
    @grid.each do |i|
      result << i.map do |card|
        if card.flipped
          card.value
        else
          "-"
        end
      end
    end
    result.each do |i|
      p i
    end
  end

end
