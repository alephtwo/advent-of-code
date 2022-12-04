defmodule Day04Test do
  use ExUnit.Case
  doctest Day04

  @puzzle_input File.read!("priv/04.txt")

  @sample_input """
  2-4,6-8
  2-3,4-5
  5-7,7-9
  2-8,3-7
  6-6,4-6
  2-6,4-8
  """

  @tag :skip
  test "part 1 example" do
    assert Day04.part_one(@sample_input) == 2
  end

  @tag :skip
  test "part 1 solution" do
    assert Day04.part_one(@puzzle_input) == 571
  end

  @tag :skip
  test "part 2 example" do
    assert Day04.part_two(@sample_input) == 4
  end

  @tag :skip
  test "part 2 solution" do
    assert Day04.part_two(@puzzle_input) == 917
  end
end
