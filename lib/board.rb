require 'pry'

class Board
  attr_reader :cells

  def initialize
    @cells = {
      "A1" => Cell.new("A1"),
      "A2" => Cell.new("A2"),
      "A3" => Cell.new("A3"),
      "A4" => Cell.new("A4"),
      "B1" => Cell.new("B1"),
      "B2" => Cell.new("B2"),
      "B3" => Cell.new("B3"),
      "B4" => Cell.new("B4"),
      "C1" => Cell.new("C1"),
      "C2" => Cell.new("C2"),
      "C3" => Cell.new("C3"),
      "C4" => Cell.new("C4"),
      "D1" => Cell.new("D1"),
      "D2" => Cell.new("D2"),
      "D3" => Cell.new("D3"),
      "D4" => Cell.new("D4"),
    }
  end

  def valid_coordinate?(coordinate)
    cells.include?(coordinate)
  end

  def valid_placement?(boat, coordinates)
    letters = []
    numbers = []
    # binding.pry
    coordinates.each do |x|
      array = x.split("")
      letters << array[0]
      numbers << array[1]
    end
    letters_strip = letters.uniq.size == 1
    numbers_strip = numbers.uniq.size == 1

    if letters_strip == true
      z = numbers == (numbers[0]..numbers[-1]).to_a
    elsif numbers_strip == true
      z = letters == (letters[0]..letters[-1]).to_a
    else
      z = false
    end
    cell_ship = []
    coordinates.each {|coord| cell_ship << @cells[coord].empty?}
    boat.length == coordinates.count && z && !cell_ship.include?(false)
  end

  def place(boat, coordinates)
    if valid_placement?(boat, coordinates)
      coordinates.each do |coord|
        @cells[coord].place_ship(boat)
      end
    end
  end

  def render(show_ships = false)
    first_row = "A " + @cells["A1"].render(show_ships) + " " + @cells["A2"].render(show_ships) + " " + @cells["A3"].render(show_ships) + " " + @cells["A4"].render(show_ships) + " \n"
    second_row = "B " + @cells["B1"].render(show_ships) + " " + @cells["B2"].render(show_ships) + " " + @cells["B3"].render(show_ships) + " " + @cells["B4"].render(show_ships) + " \n"
    third_row = "C " + @cells["C1"].render(show_ships) + " " + @cells["C2"].render(show_ships) + " " + @cells["C3"].render(show_ships) + " " + @cells["C4"].render(show_ships) + " \n"
    fourth_row = "D " + @cells["D1"].render(show_ships) + " " + @cells["D2"].render(show_ships) + " " + @cells["D3"].render(show_ships) + " " + @cells["D4"].render(show_ships) + " \n"

    board_string = "  1 2 3 4 \n" + first_row + second_row + third_row + fourth_row
  end

  def valid_shot?(player_shot)
    @cells.keys.include?(player_shot)
  end


end
