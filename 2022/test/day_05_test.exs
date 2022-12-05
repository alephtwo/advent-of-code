defmodule Day05Test do
  use ExUnit.Case
  doctest Day05

  @puzzle_input File.read!("priv/05.txt")

  @sample_input """
      [D]
  [N] [C]
  [Z] [M] [P]
   1   2   3

  move 1 from 2 to 1
  move 3 from 1 to 3
  move 2 from 2 to 1
  move 1 from 1 to 2
  """

  @tag :skip
  test "part 1 example" do
    assert Day05.part_one(@sample_input) == "CMZ"
  end

  @tag :skip
  test "part 1 solution" do
    assert Day05.part_one(@puzzle_input) == "VQZNJMWTR"
  end

  @tag :skip
  test "part 2 example" do
    assert Day05.part_two(@sample_input) == "MCD"
  end

  @tag :skip
  test "part 2 solution" do
    assert Day05.part_two(@puzzle_input) == "NLCDCLVMQ"
  end
end
