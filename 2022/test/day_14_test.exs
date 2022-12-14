defmodule Day14Test do
  @moduledoc """
  Tests for Day 14 of Advent of Code 2022.
  """
  use ExUnit.Case
  doctest Day14

  @puzzle_input File.read!("priv/14.txt")

  @sample_input """
  498,4 -> 498,6 -> 496,6
  503,4 -> 502,4 -> 502,9 -> 494,9
  """

  test "part 1 example" do
    assert Day14.part_one(@sample_input) == 24
  end

  test "part 1 solution" do
    assert Day14.part_one(@puzzle_input) == 610
  end

  test "part 2 example" do
    assert Day14.part_two(@sample_input) == 93
  end

  test "part 2 solution" do
    assert Day14.part_two(@puzzle_input) == 27_194
  end
end
