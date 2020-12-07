defmodule Day07Test do
  @moduledoc """
  Tests for Day 7 of Advent of Code 2020.
  """
  use ExUnit.Case
  doctest Day07

  @part_1_sample """
  light red bags contain 1 bright white bag, 2 muted yellow bags.
  dark orange bags contain 3 bright white bags, 4 muted yellow bags.
  bright white bags contain 1 shiny gold bag.
  muted yellow bags contain 2 shiny gold bags, 9 faded blue bags.
  shiny gold bags contain 1 dark olive bag, 2 vibrant plum bags.
  dark olive bags contain 3 faded blue bags, 4 dotted black bags.
  vibrant plum bags contain 5 faded blue bags, 6 dotted black bags.
  faded blue bags contain no other bags.
  dotted black bags contain no other bags.
  """

  @part_2_sample """
  shiny gold bags contain 2 dark red bags.
  dark red bags contain 2 dark orange bags.
  dark orange bags contain 2 dark yellow bags.
  dark yellow bags contain 2 dark green bags.
  dark green bags contain 2 dark blue bags.
  dark blue bags contain 2 dark violet bags.
  dark violet bags contain no other bags.
  """

  test "part 1 sample solution" do
    assert Day07.part_one(@part_1_sample) == 4
  end

  test "part 1 solution" do
    assert Day07.part_one() == 370
  end

  test "part 2 sample solution" do
    assert Day07.part_two(@part_2_sample) == 126
  end

  test "part 2 solution" do
    assert Day07.part_two() == 29547
  end
end
