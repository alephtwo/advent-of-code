defmodule Day02Test do
  @moduledoc """
  Tests for Day 2 of Advent of Code 2019.
  """
  use ExUnit.Case
  doctest Day02

  test "part one solution" do
    output = Day02.part_one()
    assert Enum.at(output, 0) == 3_931_283
  end

  @tag :slow
  test "part two solution" do
    assert Day02.part_two() == 6979
  end
end
