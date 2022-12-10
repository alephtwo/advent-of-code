defmodule Day10Test do
  @moduledoc """
  Tests for Day 10 of Advent of Code 2022.
  """
  use ExUnit.Case
  doctest Day10

  @puzzle_input File.read!("priv/10.txt")

  @sample_input """
  """

  test "part 1 example" do
    assert Day10.part_one(@sample_input) == :ok
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
  test "part 2 example 2" do
    assert Day09.part_two(@longer_sample_input) == :ok
  end

  @tag :skip
  test "part 2 solution" do
    assert Day09.part_two(@puzzle_input) == :ok
  end
end
