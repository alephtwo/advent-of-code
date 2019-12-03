defmodule Day03Test do
  @moduledoc """
  Tests for Day 3 of Advent of Code 2019.
  """
  use ExUnit.Case
  doctest Day03

  test "part one example one" do
    wires = [
      ["R75", "D30", "R83", "U83", "L12", "D49", "R71", "U7", "L72"],
      ["U62", "R66", "U55", "R34", "D71", "R55", "D58", "R83"]
    ]

    assert Day03.min_manhattan_distance(wires) == 159
  end

  test "part one example two" do
    wires = [
      ["R98", "U47", "R26", "D63", "R33", "U87", "L62", "D20", "R33", "U53", "R51"],
      ["U98", "R91", "D20", "R16", "D67", "R40", "U7", "R15", "U6", "R7"]
    ]

    assert Day03.min_manhattan_distance(wires) == 135
  end

  test "part one solution" do
    assert Day03.part_one() == 303
  end

  test "part two example one" do
    wires = [
      ["R75", "D30", "R83", "U83", "L12", "D49", "R71", "U7", "L72"],
      ["U62", "R66", "U55", "R34", "D71", "R55", "D58", "R83"]
    ]

    assert Day03.min_junction_distance(wires) == 610
  end

  test "part two example two" do
    wires = [
      ["R98", "U47", "R26", "D63", "R33", "U87", "L62", "D20", "R33", "U53", "R51"],
      ["U98", "R91", "D20", "R16", "D67", "R40", "U7", "R15", "U6", "R7"]
    ]

    assert Day03.min_junction_distance(wires) == 410
  end
end
