defmodule Day01Test do
  use ExUnit.Case
  doctest Day01
  @moduletag :skip

  @puzzle_input File.read!("priv/01.txt")

  @sample_input """
  1000
  2000
  3000

  4000

  5000
  6000

  7000
  8000
  9000

  10000
  """

  test "part 1 example" do
    assert Day01.part_one(@sample_input) == 24_000
  end

  test "part 1 solution" do
    assert Day01.part_one(@puzzle_input) == 68_802
  end

  test "part 2 example" do
    assert Day01.part_two(@sample_input) == 45_000
  end

  test "part 2 solution" do
    assert Day01.part_two(@puzzle_input) == 205_370
  end
end
