require './lib/ship'
require './lib/cell'
require './lib/board'
require 'pry'

class BattleshipRunner

  def initialize
    # @user_board = Board.new
    # @comp_board = Board.new
  end

  def start
    main_menu
    choose_board
    choose_ships
    comp_place
    user_place
    game_loop
    end_game
    initialize
    start
  end

  def main_menu
    print "Welcome to BATTLESHIP\nEnter p to play. Enter q to quit.\n>"
    input = gets.chomp
    if input == "q"
      exit
    end
  end

  def choose_board
    print "How large of a board do you want to play on?\n Enter a number from 4 to 9.\n>"
    @size = gets.chomp.to_i
    until [4, 5, 6, 7, 8, 9].include?(@size)
      puts "That's not an option, dummy!"
      @size = gets.chomp.to_i
    end

    @user_board = Board.new(@size)
    @comp_board = Board.new(@size)
  end

  def choose_ships
    @ships = {
      "diver" => 1,
      "submarine" => 2,
      "cruiser" => 3,
      "frigate" => 4,
      "artillery ship" => 5,
      "danger boat" => 6,
      "aircraft carrier" => 7,
      "destroyer" => 8,
      "mega ultra war ship" => 9
    }
    puts "Now it's time to choose your ships. You have #{units(@size)} ship units to work with. \nHere are your options:\n"
    sleep 3
    ship_list = ""
    @ships.each do |key, value|
      ship_list += "  #{key.capitalize}: #{value} units\n"
    end
    puts ship_list
    sleep 2
    puts "Choose your ships by entering the unit number of your desired boats, one at a time.\n>"
    remaining_units = units(@size)
    @chosen_ships = []
    choice = gets.chomp.to_i
    until remaining_units == 0
      if [1, 2, 3, 4, 5, 6, 7, 8, 9].include?(choice) == false
        puts "Seriously?! Are you typing with your face?"
        sleep 2
        puts ship_list
        puts " Try again.\n>"
        choice = gets.chomp.to_i
      elsif choice > @size
        puts "Did you really think that ship would fit on your board?"
        sleep 2
        puts ship_list
        puts "Choose something smaller.\n>"
        choice = gets.chomp.to_i
      elsif choice > remaining_units
        puts "You can't afford that boat."
        sleep 2
        puts ship_list
        puts "Choose something smaller.\n>"
        choice = gets.chomp.to_i
      else
        Ship.new(@ships.key(choice), choice)
        remaining_units -= choice
        @chosen_ships << @ships.key(choice)
        if remaining_units > 0
          puts "You have selected a(n) #{@ships.key(choice)}.\n"
          sleep 2
          puts ship_list
          puts "You have #{remaining_units} ship units left, choose wiseley!\n>"
          choice = gets.chomp.to_i
        else
          puts "..and your #{@ships.key(choice)} completes your armada. \nI will use the same ships as you!"
          sleep 3
        end
      end
    end
    #binding.pry
  end

  def units(size)
    chart = {
      4 => 5,
      5 => 8,
      6 => 12,
      7 => 16,
      8 => 21,
      9 => 27
    }
    return chart[size]
  end

  def comp_place
    # cruiser = Ship.new("cruiser", 3)
    # submarine = Ship.new("submarine", 2)

    @chosen_ships.each do |ship|
      boat = Ship.new(ship, @ships[ship])
      cells = @comp_board.cells.keys.sample(@ships[ship])
      until @comp_board.valid_placement?(boat, cells)
        cells = @comp_board.cells.keys.sample(@ships[ship])
      end
      @comp_board.place(boat, cells)

    end
    #binding.pry

  #   cells = ["A1", "B2", "C3"]
  #   until @comp_board.valid_placement?(cruiser, cells)
  #     cells = @comp_board.cells.keys.sample(3)
  #   end
  #
  #   @comp_board.place(cruiser, cells)
  #
  #   cells = ["A1", "B2"]
  #   until @comp_board.valid_placement?(submarine, cells)
  #     cells = @comp_board.cells.keys.sample(2)
  #   end
  #
  #   @comp_board.place(submarine, cells)
   end

  def user_place
    cruiser = Ship.new("cruiser", 3)
    submarine = Ship.new("submarine", 2)

    puts @user_board.render
    puts "Enter the squares for the Cruiser (3 spaces):\n>"
    input = gets.chomp
    user_coords = coordinate_scrubber(input)

    until @user_board.valid_placement?(cruiser, user_coords)
      puts "Those coordinates suck! Try again\n>"
      input = gets.chomp
      user_coords = coordinate_scrubber(input)
    end
    @user_board.place(cruiser, user_coords)

    puts @user_board.render(true)
    puts "Enter the squares for the Submarine (2 spaces):\n>"
    input = gets.chomp
    user_coords = coordinate_scrubber(input)

    until @user_board.valid_placement?(submarine, user_coords)
      puts "Those coordinates suck! Try again\n>"
      input = gets.chomp
      user_coords = coordinate_scrubber(input)
    end
    @user_board.place(submarine, user_coords)

    puts @user_board.render(true)
  end

  def coordinate_scrubber(input)
    input.delete!(",")
    input.delete!(" ")
    input.upcase!

    array = input.split("").to_a
    user_coords = []
    coord = ""
    array.each do |x|
      if coord.length < 2
        coord += x
      end
      if coord.length == 2
        user_coords << coord
        coord = ""
      end
    end
    return user_coords
  end

  def game_loop
    puts "\n=============COMPUTER BOARD=============\n#{@comp_board.render}\n==============PLAYER BOARD==============\n#{@user_board.render(true)}\n"
    user_ships = @user_board.cells.select do |key,value|
      value.ship != nil
    end
    comp_ships = @comp_board.cells.select do |key,value|
      value.ship != nil
    end
    @user_sunk = false
    @comp_sunk = false
    until @user_sunk || @comp_sunk
      turn
      @user_sunk = user_ships.all? do |key,value|
        value.ship.sunk?
      end
      @comp_sunk = comp_ships.all? do |key,value|
        value.ship.sunk?
      end
    end
  end

  def turn
    puts "Enter the coordinate for your shot:\n>"
    input = gets.chomp
    @user_shot = coordinate_scrubber(input)[0]

    until @comp_board.valid_coordinate?(@user_shot)
      puts "Please enter a valid coordinate:\n>"
      input = gets.chomp
      @user_shot = coordinate_scrubber(input)[0]
    end

    if @comp_board.cells[@user_shot].fired_upon?
      @already_fired = true
    else
      @comp_board.cells[@user_shot].fire_upon
    end

    puts "While that's in the air, I will now take a shot at you!"
    sleep 2

    @comp_shot = @user_board.cells.keys.sample

    until @user_board.cells[@comp_shot].fired_upon? == false
      @comp_shot = @user_board.cells.keys.sample
    end

    @user_board.cells[@comp_shot].fire_upon
    results
  end

  def results
     puts "\n=============COMPUTER BOARD=============\n#{@comp_board.render}\n==============PLAYER BOARD==============\n#{@user_board.render(true)}\n"
    if @already_fired == true
      puts "No problemo, keep wasting your ammo!"
      @already_fired = false
    elsif @comp_board.cells[@user_shot].render == "M"
      puts "WIFF! Your shot on #{@user_shot} was a miss."
    elsif @comp_board.cells[@user_shot].render == "H"
      puts "Dang it, you hit my ship on #{@user_shot}!"
    elsif @comp_board.cells[@user_shot].render == "X"
      puts "Dammit, you sunk my #{@comp_board.cells[@user_shot].ship.name}!"
    end

    if @user_board.cells[@comp_shot].render == "M"
      puts "My shot on #{@comp_shot} was a miss."
    elsif @user_board.cells[@comp_shot].render == "H"
      puts "Take that! I hit your ship on #{@comp_shot}!"
    elsif @user_board.cells[@comp_shot].render == "X"
      puts "IN YOUR FACE. I sunk your #{@user_board.cells[@comp_shot].ship.name}!!!!!!"
    end
  end

  def end_game
    if @user_sunk && @comp_sunk
      puts "You sunk all my ships, but I'm taking you down with me!\nTHE END"
    elsif @user_sunk
      puts "Suck it, YOU LOSE!\nGAME OVER"
    elsif @comp_sunk
      puts "Blast! You've defeated my naval armada. \nYOU WIN!\n"
    end
  end
end
