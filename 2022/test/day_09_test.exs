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

  test "adjacency" do
    assert Day09.is_adjacent({0, 0}, {1, 1})
    assert Day09.is_adjacent({0, 0}, {1, 0})
    assert Day09.is_adjacent({0, 0}, {1, -1})
    assert Day09.is_adjacent({0, 0}, {0, -1})
    assert Day09.is_adjacent({0, 0}, {-1, -1})
    assert Day09.is_adjacent({0, 0}, {-1, 0})
    assert Day09.is_adjacent({0, 0}, {-1, 1})
  end

  test "part 1 example" do
    assert Day09.part_one(@sample_input) == 13
  end

  @tag :skip
  test "part 1 solution" do
    assert Day09.part_one(@puzzle_input) == :ok
  end

  @tag :skip
  test "part 2 example" do
    assert Day09.part_two(@sample_input) == :ok
  end

  @tag :skip
  test "part 2 solution" do
    assert Day09.part_two(@puzzle_input) == :ok
  end
end
