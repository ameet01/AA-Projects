class Card
  attr_accessor :value, :flipped

  def initialize(value)
    @value = value
    @flipped = false
  end

  def reveal
    @flipped = true
  end

  def hide
    @flipped = false
  end
end
