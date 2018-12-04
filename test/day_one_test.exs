defmodule DayOneTest do
  use ExUnit.Case
  doctest DayOne

  test "part one: only positives" do
    assert DayOne.part_one([+1, +1, +1]) == 3
  end

  test "part one: mixed numbers" do
    assert DayOne.part_one([+1, +1, -2]) == 0
  end

  test "part one: only negatives" do
    assert DayOne.part_one([-1, -2, -3]) == -6
  end

  test "part one: solution" do
    assert DayOne.part_one(DayOne.parse_input()) == 402
  end
end
