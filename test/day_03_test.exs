defmodule Day03Test do
  @moduledoc """
  Tests for Day 3 of Advent of Code 2020.
  """
  use ExUnit.Case
  doctest Day03

  @sample """
  ..##.......
  #...#...#..
  .#....#..#.
  ..#.#...#.#
  .#...##..#.
  ..#.##.....
  .#.#.#....#
  .#........#
  #.##...#...
  #...##....#
  .#..#...#.#
  """

  test "part 1 parse_map sample" do
    expected = [
      [".", ".", "#", "#", ".", ".", ".", ".", ".", ".", "."],
      ["#", ".", ".", ".", "#", ".", ".", ".", "#", ".", "."],
      [".", "#", ".", ".", ".", ".", "#", ".", ".", "#", "."],
      [".", ".", "#", ".", "#", ".", ".", ".", "#", ".", "#"],
      [".", "#", ".", ".", ".", "#", "#", ".", ".", "#", "."],
      [".", ".", "#", ".", "#", "#", ".", ".", ".", ".", "."],
      [".", "#", ".", "#", ".", "#", ".", ".", ".", ".", "#"],
      [".", "#", ".", ".", ".", ".", ".", ".", ".", ".", "#"],
      ["#", ".", "#", "#", ".", ".", ".", "#", ".", ".", "."],
      ["#", ".", ".", ".", "#", "#", ".", ".", ".", ".", "#"],
      [".", "#", ".", ".", "#", ".", ".", ".", "#", ".", "#"]
    ]

    assert Day03.parse_map(@sample) == expected
  end

  test "part 1 sled sample" do
    map = Day03.parse_map(@sample)
    expected = [".", ".", "#", ".", "#", "#", ".", "#", "#", "#", "#"]
    assert Day03.sled_path(%{map: map, dx: 3, dy: 1}) == expected
  end

  test "part 1 sample solution" do
    map = Day03.parse_map(@sample)
    assert Day03.trees_on_path(%{map: map, dx: 3, dy: 1}) == 7
  end

  test "part 1 solution" do
    assert Day03.part_one() == 209
  end

  # test "part 2 solution" do
  #   assert Day03.part_two() == nil
  # end
end
