require "spec"
require "../src/*"

describe "FlattenArray" do
  it "empty" do
    FlattenArray.flatten([] of Int32 | Nil).should eq([] of Int32)
  end

  it "no nesting" do
    FlattenArray.flatten([0, 1, 2]).should eq([0, 1, 2])
  end

  it "flattens a nested array" do
    FlattenArray.flatten(Array(Array(Int32)).new).should eq([] of Int32)
  end

  it "flattens array with just integers present" do
    FlattenArray.flatten([1, [2, 3, 4, 5, 6, 7], 8]).should eq([1, 2, 3, 4, 5, 6, 7, 8])
  end

  it "5 level nesting" do
    FlattenArray.flatten([0, 2, [[2, 3], 8, 100, 4, [[[50]]]], -2]).should eq([0, 2, 2, 3, 8, 100, 4, 50, -2])
  end

  it "6 level nesting" do
    FlattenArray.flatten([1, [2, [[3]], [4, [[5]]], 6, 7], 8]).should eq([1, 2, 3, 4, 5, 6, 7, 8])
  end

  it "null values are omitted from the final result" do
    FlattenArray.flatten([1, 2, nil]).should eq([1, 2])
  end

  it "consecutive null values at the front of the list are omitted from the final result" do
    FlattenArray.flatten([nil, nil, 3]).should eq([3])
  end

  it "consecutive null values in the middle of the list are omitted from the final result" do
    FlattenArray.flatten([1, nil, nil, 4]).should eq([1, 4])
  end

  it "6 level nest list with null values" do
    FlattenArray.flatten([0, 2, [[2, 3], 8, [[100]], nil, [[nil]]], -2]).should eq([0, 2, 2, 3, 8, 100, -2])
  end

  it "all values in nested list are null" do
    FlattenArray.flatten([nil, [[[nil]]], nil, nil, [[nil, nil], nil], nil]).should eq([] of Int32)
  end
end
