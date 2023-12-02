defmodule AdventOfCode2023.Day02Test do
  use ExUnit.Case
  doctest AdventOfCode2023.Day02
  alias AdventOfCode2023.Day02
  @moduletag :skip

  @puzzle_input File.read!("priv/02.txt")

  @sample_input """
  Game 1: 3 blue, 4 red; 1 red, 2 green, 6 blue; 2 green
  Game 2: 1 blue, 2 green; 3 green, 4 blue, 1 red; 1 green, 1 blue
  Game 3: 8 green, 6 blue, 20 red; 5 blue, 4 red, 13 green; 5 green, 1 red
  Game 4: 1 green, 3 red, 6 blue; 3 green, 6 red; 3 green, 15 blue, 14 red
  Game 5: 6 red, 1 blue, 3 green; 2 blue, 1 red, 2 green
  """

  test "part 1 example" do
    assert Day02.part_one(@sample_input) == 8
  end

  test "part 1 solution" do
    assert Day02.part_one(@puzzle_input) == 2_006
  end

  test "part 2 example" do
    assert Day02.part_two(@sample_input) == 2_286
  end

  test "part 2 solution" do
    assert Day02.part_two(@puzzle_input) == 84_911
  end
end
