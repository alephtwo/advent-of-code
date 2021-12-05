defmodule Day05Test do
  use ExUnit.Case
  doctest Day05

  @sample_input """
  0,9 -> 5,9
  8,0 -> 0,8
  9,4 -> 3,4
  2,2 -> 2,1
  7,0 -> 7,4
  6,4 -> 2,0
  0,9 -> 2,9
  3,4 -> 1,4
  0,0 -> 8,8
  5,5 -> 8,2
  """

  @puzzle_input File.read!("priv/05.txt")

  test "part one example" do
    assert Day05.part_one(@sample_input) == 5
  end

  test "part one solution" do
    assert Day05.part_one(@puzzle_input) == 5835
  end

  test "part two example" do
    assert Day05.part_two(@sample_input) == 12
  end

  test "part two solution" do
    assert Day05.part_two(@puzzle_input) == 17_013
  end
end
