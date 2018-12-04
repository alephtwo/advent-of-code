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

  test "part one: solution" do
    assert Day02.part_one(Day02.parse_input()) == 7105
  end
end
