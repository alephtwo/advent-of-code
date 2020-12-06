defmodule Day06Test do
  @moduledoc """
  Tests for Day 6 of Advent of Code 2020.
  """
  use ExUnit.Case
  doctest Day06
  @moduletag :finished

  @sample """
  abc

  a
  b
  c

  ab
  ac

  a
  a
  a
  a

  b
  """

  test "part 1 sample solution" do
    assert Day06.part_one(@sample) == 11
  end

  test "part 1 solution" do
    assert Day06.part_one() == 6763
  end

  test "part 2 sample solution" do
    assert Day06.part_two(@sample) == 6
  end

  test "part 2 solution" do
    assert Day06.part_two() == 3512
  end
end
