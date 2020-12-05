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

  test "part 1 solution" do
    assert Day05.part_one() == 818
  end

  test "part 2 solution" do
    assert Day05.part_two() == nil
  end
end
