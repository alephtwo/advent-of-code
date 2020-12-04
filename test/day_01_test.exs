defmodule Day01Test do
  @moduledoc """
  Tests for Day 1 of Advent of Code 2020.
  """
  use ExUnit.Case
  doctest Day01
  @moduletag :finished

  @sample [1721, 979, 366, 299, 675, 1456]

  test "part 1 example find_pair_that_adds_to_2020" do
    assert Day01.find_pair_that_adds_to_2020(@sample) == [1721, 299]
  end

  test "part 1 example find_product_of_pair" do
    assert Day01.find_product_of_pair(@sample) == 514_579
  end

  test "part 1 solution" do
    assert Day01.part_one() == 259_716
  end

  test "part 2 example find_triplet_that_adds_to_2020" do
    assert Day01.find_triplet_that_adds_to_2020(@sample) == [979, 366, 675]
  end

  test "part 2 example find_product_of_triplet" do
    assert Day01.find_product_of_triplet(@sample) == 241_861_950
  end

  test "part 2 solution" do
    assert Day01.part_two() == 120_637_440
  end
end
