defmodule AdventOfCode2023.Day03Test do
  use ExUnit.Case
  doctest AdventOfCode2023.Day03
  alias AdventOfCode2023.Day03

  @puzzle_input File.read!("priv/03.txt")

  @sample_input """
  467..114..
  ...*......
  ..35..633.
  ......#...
  617*......
  .....+.58.
  ..592.....
  ......755.
  ...$.*....
  .664.598..
  """

  test "part 1 example" do
    assert Day03.part_one(@sample_input) == 4_361
  end

  test "part 1 solution" do
    assert Day03.part_one(@puzzle_input) == 527_369
  end

  test "part 2 example" do
    assert Day03.part_two(@sample_input) == 467_835
  end

  @tag :skip
  test "part 2 solution" do
    assert Day03.part_two(@puzzle_input) == nil
  end
end
