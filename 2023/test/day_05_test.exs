defmodule AdventOfCode2023.Day05Test do
  use ExUnit.Case
  doctest AdventOfCode2023.Day05
  alias AdventOfCode2023.Day05

  @puzzle_input File.read!("priv/05.txt")

  @sample_input """
  seeds: 79 14 55 13

  seed-to-soil map:
  50 98 2
  52 50 48

  soil-to-fertilizer map:
  0 15 37
  37 52 2
  39 0 15

  fertilizer-to-water map:
  49 53 8
  0 11 42
  42 0 7
  57 7 4

  water-to-light map:
  88 18 7
  18 25 70

  light-to-temperature map:
  45 77 23
  81 45 19
  68 64 13

  temperature-to-humidity map:
  0 69 1
  1 0 69

  humidity-to-location map:
  60 56 37
  56 93 4
  """

  test "part 1 example" do
    assert Day05.part_one(@sample_input) == 35
  end

  test "part 1 solution" do
    assert Day05.part_one(@puzzle_input) == 806_029_445
  end

  @tag :skip
  test "part 2 example" do
    assert Day05.part_two(@sample_input) == nil
  end

  @tag :skip
  test "part 2 solution" do
    assert Day05.part_two(@puzzle_input) == nil
  end
end
