defmodule AdventOfCode2023.Day02Test do
  use ExUnit.Case
  doctest AdventOfCode2023.Day02
  alias AdventOfCode2023.Day02

  @puzzle_input File.read!("priv/02.txt")

  @sample_input """
  """

  test "part 1 example" do
    assert Day02.part_one(@sample_input_1) == nil
  end

  @tag :skip
  test "part 1 solution" do
    assert Day02.part_one(@puzzle_input) == nil
  end

  @tag :skip
  test "part 2 example" do
    assert Day02.part_two(@sample_input_2) == nil
  end

  @tag :skip
  test "part 2 solution" do
    assert Day02.part_two(@puzzle_input) == nil
  end
end
