require './lib/ship'
require './lib/cell'
require './lib/board'
require 'pry'

class BattleshipRunner

  def initialize
    @user_board = Board.new
    @comp_board = Board.new
  end

  def start
    main_menu
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

  def comp_place
    @cruiser = Ship.new("cruiser", 3)
    @submarine = Ship.new("submarine", 2)

    cells = ["A1", "B2", "C3"]
    until @comp_board.valid_placement?(@cruiser, cells)
      cells = @comp_board.cells.keys.sample(3)
    end

    @comp_board.place(@cruiser, cells)

    cells = ["A1", "B2"]
    until @comp_board.valid_placement?(@submarine, cells)
      cells = @comp_board.cells.keys.sample(2)
    end

    @comp_board.place(@submarine, cells)
  end

  def user_place
    @user_cruiser = Ship.new("cruiser", 3)
    @user_submarine = Ship.new("submarine", 2)

    puts @user_board.render
    puts "Enter the squares for the Cruiser (3 spaces):\n>"
    input = gets.chomp
    user_coords = coordinate_scrubber(input)

    until @user_board.valid_placement?(@user_cruiser, user_coords)
      puts "Those coordinates suck! Try again\n>"
      input = gets.chomp
      user_coords = coordinate_scrubber(input)
    end
    @user_board.place(@user_cruiser, user_coords)

    puts @user_board.render(true)
    puts "Enter the squares for the Submarine (2 spaces):\n>"
    input = gets.chomp
    user_coords = coordinate_scrubber(input)

    until @user_board.valid_placement?(@user_submarine, user_coords)
      puts "Those coordinates suck! Try again\n>"
      input = gets.chomp
      user_coords = coordinate_scrubber(input)
    end
    @user_board.place(@user_submarine, user_coords)

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
    comp_sunk = false
    until @user_sunk || comp_sunk
      turn
      @user_sunk = user_ships.all? do |key,value|
        value.ship.sunk?
      end
      comp_sunk = comp_ships.all? do |key,value|
        value.ship.sunk?
      end
    end
  end

  def turn
    puts "Enter the coordinate for your shot:\n>"
    input = gets.chomp
    @player_shot = coordinate_scrubber(input)[0]

    until @comp_board.valid_shot?(@player_shot)
      puts "Please enter a valid coordinate:\n>"
      input = gets.chomp
      @player_shot = coordinate_scrubber(input)[0]
    end

    if @comp_board.cells[@player_shot].fired_upon?
      @already_fired = true
    else
      @comp_board.cells[@player_shot].fire_upon
    end

    puts "The computer will now take a shot at you!"

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
    elsif @comp_board.cells[@player_shot].render == "M"
      puts "WIFF! Your shot on #{@player_shot} was a miss."
    elsif @comp_board.cells[@player_shot].render == "H"
      puts "Dang it, you hit my ship on #{@player_shot}!"
    elsif @comp_board.cells[@player_shot].render == "X"
      puts "Dammit, you sunk my ship!"
    end

    if @user_board.cells[@comp_shot].render == "M"
      puts "My shot on #{@comp_shot} was a miss."
    elsif @user_board.cells[@comp_shot].render == "H"
      puts "Take that! I hit your ship on #{@comp_shot}!"
    elsif @user_board.cells[@comp_shot].render == "X"
      puts "IN YOUR FACE. I sunk your ship!!!!!!"
    end
  end

  def end_game
    if @user_sunk
      puts "Suck it, YOU LOSE!\n"
    else
      puts "Blast! You've defeated my naval armada. \nYou Win!\n"
    end
  end

end
