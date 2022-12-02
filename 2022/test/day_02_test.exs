defmodule Day02Test do
  use ExUnit.Case
  doctest Day02

  @puzzle_input File.read!("priv/02.txt")

  @sample_input """
  A Y
  B X
  C Z
  """

  @tag :skip
  test "part 1 example" do
    assert Day02.part_one(@sample_input) == 15
  end

  @tag :skip
  test "part 1 solution" do
    assert Day02.part_one(@puzzle_input) == 14_297
  end

  @tag :skip
  test "part 2 example" do
    assert Day02.part_two(@sample_input) == 12
  end

  @tag :skip
  test "part 2 solution" do
    assert Day02.part_two(@puzzle_input) == 10_498
  end
end
