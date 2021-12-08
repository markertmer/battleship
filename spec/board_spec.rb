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
end
