defmodule Day15Test do
  @moduledoc """
  Tests for Day 15 of Advent of Code 2022.
  """
  use ExUnit.Case
  doctest Day15

  @puzzle_input File.read!("priv/15.txt")

  @sample_input """
  Sensor at x=2, y=18: closest beacon is at x=-2, y=15
  Sensor at x=9, y=16: closest beacon is at x=10, y=16
  Sensor at x=13, y=2: closest beacon is at x=15, y=3
  Sensor at x=12, y=14: closest beacon is at x=10, y=16
  Sensor at x=10, y=20: closest beacon is at x=10, y=16
  Sensor at x=14, y=17: closest beacon is at x=10, y=16
  Sensor at x=8, y=7: closest beacon is at x=2, y=10
  Sensor at x=2, y=0: closest beacon is at x=2, y=10
  Sensor at x=0, y=11: closest beacon is at x=2, y=10
  Sensor at x=20, y=14: closest beacon is at x=25, y=17
  Sensor at x=17, y=20: closest beacon is at x=21, y=22
  Sensor at x=16, y=7: closest beacon is at x=15, y=3
  Sensor at x=14, y=3: closest beacon is at x=15, y=3
  Sensor at x=20, y=1: closest beacon is at x=15, y=3
  """

  test "part 1 example" do
    assert Day15.part_one(@sample_input, 10) == 26
  end

  @tag :skip
  test "part 1 solution" do
    assert Day15.part_one(@puzzle_input, 2_000_000) == :ok
  end

  @tag :skip
  test "part 2 example" do
    assert Day15.part_two(@sample_input) == :ok
  end

  @tag :skip
  test "part 2 solution" do
    assert Day15.part_two(@puzzle_input) == :ok
  end
end
