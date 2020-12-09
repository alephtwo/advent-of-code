defmodule Day09Test do
  @moduledoc """
  Tests for Day 9 of Advent of Code 2020.
  """
  use ExUnit.Case
  doctest Day09

  @sample """
  35
  20
  15
  25
  47
  40
  62
  55
  65
  95
  102
  117
  150
  182
  127
  219
  299
  277
  309
  576
  """

  test "part 1 sample solution" do
    assert Day09.part_one(@sample, 5) == 127
  end

  # test "part 1 solution" do
  #   assert Day09.part_one() == :ok
  # end

  # test "part 2 sample solution" do
  #   assert Day09.part_two(@sample) == :ok
  # end

  # test "part 2 solution" do
  #   assert Day09.part_two() == :ok
  # end
end
