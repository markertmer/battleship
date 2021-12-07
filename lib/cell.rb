require './lib/ship'

class Cell
  attr_reader :coordinate, :ship

  def initialize(coordinate)
    @coordinate = coordinate
  end

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

  def fire_upon
    ship.hit if !fired_upon? 
  end

  def fired_upon?
    if ship.health == ship.length
      return false
    else
      return true
    end
  end

end
