defmodule DayThreeTest do
  use ExUnit.Case
  doctest DayThree

  test "part one dummy" do
    assert DayThree.part_one(1) == 0
    assert DayThree.part_one(12) == 3
    assert DayThree.part_one(23) == 2
    assert DayThree.part_one(1024) == 31
  end

  test "part one actual" do
    assert DayThree.part_one(347_991) == 480
  end

  test "part two actual" do
    assert DayThree.part_two(347_991) == 349975
  end
end
