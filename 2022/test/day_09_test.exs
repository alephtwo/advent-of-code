defmodule Day09Test do
  @moduledoc """
  Tests for Day 9 of Advent of Code 2022.
  """
  use ExUnit.Case
  doctest Day09

  @puzzle_input File.read!("priv/09.txt")

  @sample_input """
  R 4
  U 4
  L 3
  D 1
  R 4
  D 1
  L 5
  R 2
  """

  @longer_sample_input """
  R 5
  U 8
  L 8
  D 3
  R 17
  D 10
  L 25
  U 20
  """

  test "part 1 example" do
    assert Day09.part_one(@sample_input) == 13
  end

  test "part 1 solution" do
    assert Day09.part_one(@puzzle_input) == 6_243
  end

  test "part 2 example" do
    assert Day09.part_two(@sample_input) == 1
  end

  test "part 2 example 2" do
    assert Day09.part_two(@longer_sample_input) == 36
  end

  test "part 2 solution" do
    assert Day09.part_two(@puzzle_input) == :ok
  end
end
