defmodule Day03Test do
  @moduledoc """
  Tests for day three.
  """
  use ExUnit.Case
  doctest Day03

  test "part one: example" do
    overlaps = Day03.part_one([
      "#1 @ 1,3: 4x4",
      "#2 @ 3,1: 4x4",
      "#3 @ 5,5: 2x2"
    ])

    assert overlaps == 4
  end
end
