require './lib/ship'

class Cell
  attr_reader :location
  
  def initialize(location)
    @location = location
  end

end
