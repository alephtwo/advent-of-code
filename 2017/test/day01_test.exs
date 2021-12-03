defmodule DayOneTest do
  use ExUnit.Case
  doctest DayOne

  test "part one 1122" do
    assert DayOne.part_one([1, 1, 2, 2]) == 3
  end

  test "part one 1111" do
    assert DayOne.part_one([1, 1, 1, 1]) == 4
  end

  test "part one 1234" do
    assert DayOne.part_one([1, 2, 3, 4]) == 0
  end

  test "part one 91212129" do
    assert DayOne.part_one([9, 1, 2, 1, 2, 1, 2, 9]) == 9
  end

  test "part one actual input" do
    assert DayOne.part_one(DayOne.get_input()) == 1034
  end

  test "part two 1212" do
    assert DayOne.part_two([1, 2, 1, 2]) == 6
  end

  test "part two 1221" do
    assert DayOne.part_two([1, 2, 2, 1]) == 0
  end

  test "part two 123425" do
    assert DayOne.part_two([1, 2, 3, 4, 2, 5]) == 4
  end

  test "part two 123123" do
    assert DayOne.part_two([1, 2, 3, 1, 2, 3]) == 12
  end

  test "part two 12131415" do
    assert DayOne.part_two([1, 2, 1, 3, 1, 4, 1, 5]) == 4
  end

  test "part two actual input" do
    assert DayOne.part_two(DayOne.get_input()) == 1356
  end
end
