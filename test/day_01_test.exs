defmodule Day01Test do
  @moduledoc """
  Tests for Day 1 of Advent of Code 2020.
  """
  use ExUnit.Case
  doctest Day01

  @sample [1721, 979, 366, 299, 675, 1456] 

  test "part 1 example find_pair_that_adds_to_2020" do
    assert Day01.find_pair_that_adds_to_2020(@sample) == [1721, 299]
  end

  test "part 1 example find_product_of_pair" do
    assert Day01.find_product_of_pair(@sample) == 514_579
  end

  test "part 1 solution" do
    assert Day01.part_one == 259716
  end
end
