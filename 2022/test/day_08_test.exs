defmodule Day08Test do
  @moduledoc """
  Tests for Day 8 of Advent of Code 2022.
  """
  use ExUnit.Case
  doctest Day08

  @puzzle_input File.read!("priv/08.txt")

  @sample_input """
  30373
  25512
  65332
  33549
  35390
  """

  @tag :skip
  test "part 1 example" do
    assert Day08.part_one(@sample_input) == 21
  end

  @tag :skip
  test "part 1 solution" do
    assert Day08.part_one(@puzzle_input) == 1_669
  end

  @tag :skip
  test "part 2 example" do
    assert Day08.part_two(@sample_input) == 8
  end

  @tag :skip
  test "part 2 solution" do
    assert Day08.part_two(@puzzle_input) == 331_344
  end
end
