defmodule DayOneTest do
  @moduledoc """
  Tests for day one.
  """
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

  test "part two: first example" do
    assert DayOne.part_two([+1, -1]) == 0
  end

  test "part two: second example" do
    assert DayOne.part_two([+3, +3, +4, -2, -4]) == 10
  end

  test "part two: third example" do
    assert DayOne.part_two([-6, +3, +8, +5, -6]) == 5
  end

  test "part two: fourth example" do
    assert DayOne.part_two([+7, +7, -2, -7, -4]) == 14
  end

  # This test is really quite slow...
  # test "part two: solution" do
  #   assert DayOne.part_two(DayOne.parse_input()) == 481
  # end
end
