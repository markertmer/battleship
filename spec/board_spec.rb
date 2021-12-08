require './lib/ship'
require './lib/cell'
require './lib/board'
require 'pry'

RSpec.describe "Cell" do
  it "exists" do
    board = Board.new
    expect(board).to be_instance_of(Board)
  end

  it "has coordinates" do
    board = Board.new
    expect(board.cells.keys).to eq(["A1","A2","A3","A4","B1","B2","B3","B4","C1","C2","C3","C4","D1","D2","D3","D4"])
  end

  it "validates the coordinate" do
    board = Board.new
    expect(board.valid_coordinate?("A1")).to be(true)
    expect(board.valid_coordinate?("E1")).to be(false)
  end

  it "maps ships to placement" do
    board = Board.new
    cruiser = Ship.new("Cruiser", 3)
    submarine = Ship.new("Submarine", 2)
    expect(board.valid_placement?(cruiser, ["A1", "A2"])).to be(false)
    expect(board.valid_placement?(submarine, ["A2", "A3", "A4"])).to be(false)
    expect(board.valid_placement?(submarine, ["A2", "A3"])).to be(true)
    expect(board.valid_placement?(cruiser, ["A2", "A3", "A4"])).to be(true)
  end

  it "validates consecutive coordinates" do
    board = Board.new
    cruiser = Ship.new("Cruiser", 3)
    submarine = Ship.new("Submarine", 2)
    expect(board.valid_placement?(cruiser, ["A1", "A2", "A4"])).to be(false)
  end

end
