defmodule Day01Test do
  use ExUnit.Case
  doctest Day01

  @puzzle_input File.read!("priv/01.txt")

  # not yet implemented
  test "part 1 example" do
    assert Day01.part_one(@sample_input) == 24_000
  end

  # not yet implemented
  test "part 1 solution" do
    assert Day01.part_one(@puzzle_input) == 68_802
  end

  # not yet implemented
  test "part 2 example" do
    assert Day01.part_two(@sample_input) == 45_000
  end

  # not yet implemented
  test "part 2 solution" do
    assert Day01.part_two(@puzzle_input) == 205_370
  end
end
