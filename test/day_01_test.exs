defmodule Day01Test do
  @moduledoc """
  Tests for Day 1 of Advent of Code 2020.
  """
  use ExUnit.Case
  doctest Day01

  test "part 1 example" do
    input = [1721, 979, 366, 299, 675, 1456]
    assert Day01.process_expense_report(input) == 514579
  end
end
