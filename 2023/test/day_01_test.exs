defmodule AdventOfCode2023.Day01Test do
  use ExUnit.Case
  doctest AdventOfCode2023.Day01
  alias AdventOfCode2023.Day01

  @puzzle_input File.read!("priv/01.txt")

  @sample_input """
  """

  test "part 1 example" do
    assert Day01.part_one(@sample_input) == nil
  end

  test "part 1 solution" do
    assert Day01.part_one(@puzzle_input) == nil
  end

  test "part 2 example" do
    assert Day01.part_two(@sample_input) == nil
  end

  test "part 2 solution" do
    assert Day01.part_two(@puzzle_input) == nil
  end
end