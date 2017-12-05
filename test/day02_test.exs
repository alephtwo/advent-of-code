defmodule DayTwoTest do
  use ExUnit.Case
  doctest DayTwo

  test "part one dummy" do
    spreadsheet = [
      [5, 1, 9, 5],
      [7, 5, 3],
      [2, 4, 6, 8]
    ]
    assert DayTwo.part_one(spreadsheet) == 18
  end

  test "part one" do
    assert DayTwo.part_one(DayTwo.file_input()) == 44216
  end

  test "part two dummy" do
    spreadsheet = [
      [5, 9, 2, 8],
      [9, 4, 7, 3],
      [3, 8, 6, 5]
    ]
    assert DayTwo.part_two(spreadsheet) == 9
  end

  test "part two" do
    assert DayTwo.part_two(DayTwo.file_input()) == 320
  end
end
