defmodule Day07Test do
  use ExUnit.Case
  doctest Day07

  @puzzle_input File.read!("priv/07.txt")

  @sample_input """
  """

  test "part 1 example" do
    assert Day07.part_one(@sample_input) == :ok
  end

  @tag :skip
  test "part 1 solution" do
    assert Day07.part_one(@puzzle_input) == :ok
  end

  @tag :skip
  test "part 2 example" do
    assert Day07.part_two(@sample_input_1) == :ok
  end

  @tag :skip
  test "part 2 solution" do
    assert Day07.part_two(@puzzle_input) == :ok
  end
end
