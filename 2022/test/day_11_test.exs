defmodule Day11Test do
  @moduledoc """
  Tests for Day 11 of Advent of Code 2022.
  """
  use ExUnit.Case
  doctest Day11

  @puzzle_input File.read!("priv/11.txt")

  @sample_input """
  """

  test "part 1 example" do
    assert Day11.part_one(@sample_input) == :ok
  end

  @tag :skip
  test "part 1 solution" do
    assert Day11.part_one(@puzzle_input) == :ok
  end

  @tag :skip
  test "part 2 example" do
    assert Day11.part_two(@longer_sample_input) == :ok
  end

  @tag :skip
  test "part 2 solution" do
    assert Day11.part_two(@puzzle_input) == :ok
  end
end
