defmodule Day03Test do
  use ExUnit.Case
  doctest Day03

  @puzzle_input File.read!("priv/03.txt")

  @sample_input """
  vJrwpWtwJgWrhcsFMMfFFhFp
  jqHRNqRjqzjGDLGLrsFMfFZSrLrFZsSL
  PmmdzqPrVvPwwTWBwg
  wMqvLMZHhHMvwLHjbvcjnnSBnvTQFn
  ttgJtRGJQctTZtZT
  CrZsJsPPZsGzwwsLwLmpwMDw
  """

  test "part 1 example" do
    assert Day03.part_one(@sample_input) == 157
  end

  test "part 1 solution" do
    assert Day03.part_one(@puzzle_input) == 7_716
  end

  test "part 2 example" do
    assert Day03.part_two(@sample_input) == 70
  end

  test "part 2 solution" do
    assert Day03.part_two(@puzzle_input) == 2_973
  end
end
