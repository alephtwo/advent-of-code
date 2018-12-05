defmodule Day03Test do
  @moduledoc """
  Tests for day three.
  """
  use ExUnit.Case
  doctest Day03

  test "part one: example" do
    overlaps =
      Day03.part_one([
        "#1 @ 1,3: 4x4",
        "#2 @ 3,1: 4x4",
        "#3 @ 5,5: 2x2"
      ])

    assert overlaps == 4
  end

  test "part one: no overlaps" do
    assert Day03.part_one(["#1 @ 1,3: 4x4"]) == 0
    assert Day03.part_one(["#1 @ 1,3: 4x4", "#3 @ 5,5: 2x2"]) == 0
  end

  test "part one: only overlaps" do
    assert Day03.part_one(["#1 @ 1,3: 4x4", "#2 @ 1,3: 5x5"]) == 16
  end

  test "part one: small row" do
    assert Day03.part_one(["#1 @ 2,2: 5x5", "#2 @ 2,6: 5x5"]) == 5
  end
end
