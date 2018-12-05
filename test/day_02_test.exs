defmodule Day02Test do
  @moduledoc """
  Tests for day two.
  """
  use ExUnit.Case
  doctest Day02

  test "part one: example" do
    checksum =
      Day02.part_one([
        "abcdef",
        "bababc",
        "abbcde",
        "abcccd",
        "aabcdd",
        "abcdee",
        "ababab"
      ])

    assert checksum == 12
  end

  @tag :time_consuming
  test "part one: solution" do
    assert Day02.part_one(Day02.parse_input()) == 7105
  end

  test "part two: example" do
    value =
      Day02.part_two([
        "abcde",
        "fghij",
        "klmno",
        "pqrst",
        "fguij",
        "axcye",
        "wvxyz"
      ])

    assert value == "fgij"
  end

  @tag :time_consuming
  test "part two: solution" do
    assert Day02.part_two(Day02.parse_input()) == "omlvgdokxfncvqyersasjziup"
  end
end
