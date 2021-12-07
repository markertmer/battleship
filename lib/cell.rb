require './lib/ship'

class Cell
  attr_reader :coordinate, :ship

  def initialize(coordinate)
    @coordinate = coordinate
  end

  # def ship
  # end

  def empty?
    if @ship == nil
      return true
    else
      return false
    end
  end

  def place_ship(boat)
    @ship = boat
  end

end
