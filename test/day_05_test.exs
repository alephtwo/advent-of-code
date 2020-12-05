defmodule Day05Test do
  @moduledoc """
  Tests for Day 5 of Advent of Code 2020.
  """
  use ExUnit.Case
  doctest Day05

  test "part 1 sample solutions" do
    assert Day05.parse_boarding_pass("BFFFBBFRRR") == %{
             row: 70,
             column: 7,
             seat_id: 567
           }

    assert Day05.parse_boarding_pass("FFFBBBFRRR") == %{
             row: 14,
             column: 7,
             seat_id: 119
           }

    assert Day05.parse_boarding_pass("BBFFBBFRLL") == %{
             row: 102,
             column: 4,
             seat_id: 820
           }
  end

  test "test binary partition" do
    assert Day05.resolve_binary_partition("BFFFBBF") == 70
    assert Day05.resolve_binary_partition("RRR") == 7

    assert Day05.resolve_binary_partition("FFFBBBF") == 14
    assert Day05.resolve_binary_partition("RRR") == 7

    assert Day05.resolve_binary_partition("BBFFBBF") == 102
    assert Day05.resolve_binary_partition("RLL") == 4
  end

  test "part 1 solution" do
    assert Day05.part_one() == 818
  end

  test "part 2 solution" do
    assert Day05.part_two() == 559
  end
end
