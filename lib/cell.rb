require './lib/ship'

class Cell
  attr_reader :coordinate

  def initialize(coordinate)
    @coordinate = coordinate
  end

  def ship
  end

  def empty?
    return true
  end

end
