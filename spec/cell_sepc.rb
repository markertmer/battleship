require './lib/ship'
require './lib/cell'
require 'pry'


RSpec.describe "Cell" do
  it "exists" do
    cell = Cell.new("B4")
    expect(cell).to be_instance_of(Cell)
  end

  it "Checks Location of Argunment" do
    cell = Cell.new("B4")
    #binding.pry
    expect(cell.coordinate).to eq("B4")
  end

end
