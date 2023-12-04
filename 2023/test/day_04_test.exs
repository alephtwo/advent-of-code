defmodule AdventOfCode2023.Day04Test do
  use ExUnit.Case
  doctest AdventOfCode2023.Day04
  alias AdventOfCode2023.Day04
  @moduletag :skip

  @puzzle_input File.read!("priv/04.txt")

  @sample_input """
  Card 1: 41 48 83 86 17 | 83 86  6 31 17  9 48 53
  Card 2: 13 32 20 16 61 | 61 30 68 82 17 32 24 19
  Card 3:  1 21 53 59 44 | 69 82 63 72 16 21 14  1
  Card 4: 41 92 73 84 69 | 59 84 76 51 58  5 54 83
  Card 5: 87 83 26 28 32 | 88 30 70 12 93 22 82 36
  Card 6: 31 18 13 56 72 | 74 77 10 23 35 67 36 11
  """

  test "part 1 example" do
    assert Day04.part_one(@sample_input) == 13
  end

  test "part 1 solution" do
    assert Day04.part_one(@puzzle_input) == 21_088
  end

  test "part 2 example" do
    assert Day04.part_two(@sample_input) == 30
  end

  test "part 2 solution" do
    assert Day04.part_two(@puzzle_input) == 6_874_754
  end
end
