defmodule AdventOfCode2023.Day03Test do
  use ExUnit.Case
  doctest AdventOfCode2023.Day03
  alias AdventOfCode2023.Day03

  @puzzle_input File.read!("priv/03.txt")

  @sample_input """
  """

  test "part 1 example" do
    assert Day03.part_one(@sample_input) == nil
  end

  @tag :skip
  test "part 1 solution" do
    assert Day03.part_one(@puzzle_input) == nil
  end

  @tag :skip
  test "part 2 example" do
    assert Day03.part_two(@sample_input) == nil
  end

  @tag :skip
  test "part 2 solution" do
    assert Day03.part_two(@puzzle_input) == nil
  end
end
