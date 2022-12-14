defmodule Day14Test do
  @moduledoc """
  Tests for Day 14 of Advent of Code 2022.
  """
  use ExUnit.Case
  doctest Day14

  @puzzle_input File.read!("priv/14.txt")

  @sample_input """
  """

  test "part 1 example" do
    assert Day14.part_one(@sample_input) == :ok
  end

  @tag :skip
  test "part 1 solution" do
    assert Day14.part_one(@puzzle_input) == :ok
  end

  @tag :skip
  test "part 2 example" do
    assert Day14.part_two(@sample_input) == :ok
  end

  @tag :skip
  test "part 2 solution" do
    assert Day14.part_two(@puzzle_input) == :ok
  end
end