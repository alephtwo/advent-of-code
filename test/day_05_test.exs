defmodule Day05Test do
  @moduledoc """
  Tests for Day 5 of Advent of Code 2020.
  """
  use ExUnit.Case
  doctest Day05
  @moduletag :finished

  test "part 1 sample solutions" do
    assert Day05.parse_seat_id("BFFFBBFRRR") == 567
    assert Day05.parse_seat_id("FFFBBBFRRR") == 119
    assert Day05.parse_seat_id("BBFFBBFRLL") == 820
  end

  test "test binary partition" do
    assert Day05.partition("BFFFBBF") == 70
    assert Day05.partition("RRR") == 7

    assert Day05.partition("FFFBBBF") == 14
    assert Day05.partition("RRR") == 7

    assert Day05.partition("BBFFBBF") == 102
    assert Day05.partition("RLL") == 4
  end

  test "part 1 solution", do: assert(Day05.part_one() == 818)
  test "part 2 solution", do: assert(Day05.part_two() == 559)
end
