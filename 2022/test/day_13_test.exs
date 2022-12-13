defmodule Day13Test do
  @moduledoc """
  Tests for Day 13 of Advent of Code 2022.
  """
  use ExUnit.Case
  doctest Day13

  @puzzle_input File.read!("priv/13.txt")

  @sample_input """
  """

  test "part 1 example" do
    assert Day13.part_one(@sample_input) == :ok
  end

  @tag :skip
  test "part 1 solution" do
    assert Day13.part_one(@puzzle_input) == :ok
  end

  @tag :skip
  test "part 2 example" do
    assert Day13.part_two(@sample_input) == :ok
  end

  @tag :skip
  test "part 2 solution" do
    assert Day13.part_two(@puzzle_input) == :ok
  end
end
