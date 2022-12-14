defmodule Day13Test do
  @moduledoc """
  Tests for Day 13 of Advent of Code 2022.
  """
  use ExUnit.Case
  doctest Day13

  @puzzle_input File.read!("priv/13.txt")

  @sample_input """
  [1,1,3,1,1]
  [1,1,5,1,1]

  [[1],[2,3,4]]
  [[1],4]

  [9]
  [[8,7,6]]

  [[4,4],4,4]
  [[4,4],4,4,4]

  [7,7,7,7]
  [7,7,7]

  []
  [3]

  [[[]]]
  [[]]

  [1,[2,[3,[4,[5,6,7]]]],8,9]
  [1,[2,[3,[4,[5,6,0]]]],8,9]
  """

  @tag :skip
  test "part 1 example" do
    assert Day13.part_one(@sample_input) == 13
  end

  @tag :skip
  test "part 1 solution" do
    assert Day13.part_one(@puzzle_input) == 6_369
  end

  @tag :skip
  test "part 2 example" do
    assert Day13.part_two(@sample_input) == 140
  end

  @tag :skip
  test "part 2 solution" do
    assert Day13.part_two(@puzzle_input) == 25_800
  end
end
