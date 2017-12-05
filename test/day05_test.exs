defmodule DayFiveTest do
  use ExUnit.Case
  doctest DayFive

  test "part one dummy" do
    assert DayFive.steps_to_escape_part_one([0, 3, 0, 1, -3]) == 5
  end
end
