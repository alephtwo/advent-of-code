defmodule DaySixTest do
  use ExUnit.Case
  doctest DaySix

  test "part one dummy" do
    assert DaySix.steps_to_detect_infinite_loop([0, 2, 7, 0]) == 5
  end
end
