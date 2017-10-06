class Tile
  attr_accessor :value, :given

  def initialize(value)
    @value = value
    @value == 0 ? @given = false : @given = true
  end

end
