require './lib/ship'

class Cell
  attr_reader :location

  def initialize(location)
    @location = location
  end

  def coordinate
    return @location
  end

end
