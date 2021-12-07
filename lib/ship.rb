class Ship
  attr_reader :name, :length

  def initialize(name, length)
    @name = name
    @length = length
    @health = 0
  end

  def health
    @health = @health + @length
    return @health
  end


end
