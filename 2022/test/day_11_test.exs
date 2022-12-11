defmodule Day11Test do
  @moduledoc """
  Tests for Day 11 of Advent of Code 2022.
  """
  use ExUnit.Case
  doctest Day11

  @puzzle_input File.read!("priv/11.txt")

  @sample_input """
  Monkey 0:
    Starting items: 79, 98
    Operation: new = old * 19
    Test: divisible by 23
      If true: throw to monkey 2
      If false: throw to monkey 3

  Monkey 1:
    Starting items: 54, 65, 75, 74
    Operation: new = old + 6
    Test: divisible by 19
      If true: throw to monkey 2
      If false: throw to monkey 0

  Monkey 2:
    Starting items: 79, 60, 97
    Operation: new = old * old
    Test: divisible by 13
      If true: throw to monkey 1
      If false: throw to monkey 3

  Monkey 3:
    Starting items: 74
    Operation: new = old + 3
    Test: divisible by 17
      If true: throw to monkey 0
      If false: throw to monkey 1
  """

  test "part 1 example" do
    assert Day11.part_one(@sample_input) == 10_605
  end

  test "part 1 solution" do
    assert Day11.part_one(@puzzle_input) == 69_918
  end

  test "part 2 example" do
    assert Day11.part_two(@sample_input) == 2_713_310_158
  end

  test "part 2 solution" do
    assert Day11.part_two(@puzzle_input) == 19_573_408_701
  end
end
