defmodule DayFiveTest do
  use ExUnit.Case
  doctest DayFive

  test "part one dummy" do
    result = DayFive.steps_to_escape_part_one([0, 3, 0, 1, -3])
    assert result == {5, [2, 5, 0, 1, -2]}
  end

  # test "part one actual (cursed, do not run)" do
  #   assert DayFive.part_one(DayFive.get_input()) == 354121
  # end

  test "part two dummy" do
    result = DayFive.steps_to_escape_part_two([0, 3, 0, 1, -3])
    assert result == {10, [2, 3, 2, 3, -1]}
  end

  # test "part two actual (cursed, do not run!)" do
  #   assert DayFive.part_two(DayFive.get_input()) == 27283023
  # end
end
