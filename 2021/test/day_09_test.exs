defmodule Day09Test do
  use ExUnit.Case
  doctest Day09

  @sample_input """
  2199943210
  3987894921
  9856789892
  8767896789
  9899965678
  """

  @puzzle_input File.read!("priv/09.txt")

  test "part one example" do
    assert Day09.part_one(@sample_input) == 15
  end

  @tag :unimplemented
  test "part one solution" do
    assert Day09.part_one(@puzzle_input) == nil
  end

  @tag :unimplemented
  test "part two example" do
    assert Day09.part_two(@sample_input) == nil
  end

  @tag :unimplemented
  test "part two solution" do
    assert Day09.part_two(@puzzle_input) == nil
  end
end
