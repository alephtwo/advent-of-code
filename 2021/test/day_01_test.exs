defmodule Day01Test do
  use ExUnit.Case
  doctest Day01
  @moduletag :finished

  @sample_input """
  199
  200
  208
  210
  200
  207
  240
  269
  260
  263
  """

  @puzzle_input File.read!("priv/01.txt")

  test "part 1 example" do
    assert Day01.part_one(@sample_input) == 7
  end

  test "part 1 solution" do
    assert Day01.part_one(@puzzle_input) == 1482
  end

  test "part 2 example" do
    assert Day01.part_two(@sample_input) == 5
  end

  test "part 2 solution" do
    assert Day01.part_two(@puzzle_input) == 1518
  end
end
