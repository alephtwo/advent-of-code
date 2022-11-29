defmodule Day01Test do
  use ExUnit.Case
  doctest Day01

  @puzzle_input File.read!("priv/01.txt")
  @sample_input """
  """

  # not yet implemented
  @tag :skip
  test "part 1 example" do
    assert Day01.part_one(@sample_input) == :ok
  end

  # not yet implemented
  @tag :skip
  test "part 1 solution" do
    assert Day01.part_one(@puzzle_input) == :ok
  end

  # not yet implemented
  @tag :skip
  test "part 2 example" do
    assert Day01.part_two(@sample_input) == :ok
  end

  # not yet implemented
  @tag :skip
  test "part 2 solution" do
    assert Day01.part_one(@puzzle_input) == :ok
  end
end
