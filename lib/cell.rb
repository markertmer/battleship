
class Cell
  attr_reader :coordinate, :ship, :fired_upon

  def initialize(coordinate)
    @coordinate = coordinate
    @fired_upon = false
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
    if fired_upon?
      #do nothing
    elsif !empty? #!fired_upon? && !empty?
      @fired_upon = true
      ship.hit
    else  #elsif !fired_upon?
      @fired_upon = true
    end
  end

  def fired_upon?
    @fired_upon
  end

  def render(show_ships = false)
    if empty?
      if fired_upon?
        return "M"
      else
        return "."
      end
    elsif !empty?
      if @ship.sunk?
        return "X"
      elsif fired_upon?
        return "H"
      elsif show_ships == true
        return "S"
      else
        return "."
      end
    end

    # if !empty? && @ship.sunk?
    #   return "X"
    # elsif show == true && !empty?  #@ship != nil
    #   return "S"
    # elsif @fired_upon == false
    #   return "."
    # elsif fired_upon? && empty?  #@ship = nil
    #   return "M"
    # elsif fired_upon? && !empty?  #@ship != nil
    #   return "H"

  end
end
