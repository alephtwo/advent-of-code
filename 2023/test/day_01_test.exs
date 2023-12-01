defmodule AdventOfCode2023.Day01Test do
  use ExUnit.Case
  doctest AdventOfCode2023.Day01
  alias AdventOfCode2023.Day01
  @moduletag :skip

  @puzzle_input File.read!("priv/01.txt")

  @sample_input_1 """
  1abc2
  pqr3stu8vwx
  a1b2c3d4e5f
  treb7uchet
  """

  @sample_input_2 """
  two1nine
  eightwothree
  abcone2threexyz
  xtwone3four
  4nineeightseven2
  zoneight234
  7pqrstsixteen
  """

  test "part 1 example" do
    assert Day01.part_one(@sample_input_1) == 142
  end

  test "part 1 solution" do
    assert Day01.part_one(@puzzle_input) == 53_080
  end

  test "part 2 example" do
    assert Day01.part_two(@sample_input_2) == 281
  end

  test "part 2 solution" do
    assert Day01.part_two(@puzzle_input) == 53_268
  end
end
