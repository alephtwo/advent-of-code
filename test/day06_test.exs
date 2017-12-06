defmodule DaySixTest do
  use ExUnit.Case
  doctest DaySix

  test "part one choose next" do
    assert DaySix.choose_next_bank([0, 2, 7, 0]) == {7, 2}
  end

  test "part one update banks" do
    assert DaySix.update_banks([0, 2, 7, 0]) == [2, 4, 1, 2]
    assert DaySix.update_banks([2, 4, 1, 2]) == [3, 1, 2, 3]
    assert DaySix.update_banks([3, 1, 2, 3]) == [0, 2, 3, 4]
    assert DaySix.update_banks([1, 3, 4, 1]) == [2, 4, 1, 2]
  end

  test "part one rotate left" do
    assert DaySix.rotate_left([0, 1, 2], -1) == [2, 0, 1]
    assert DaySix.rotate_left([0, 1, 2], 0) == [0, 1, 2]
    assert DaySix.rotate_left([0, 1, 2], 1) == [1, 2, 0]
    assert DaySix.rotate_left([0, 1, 2], 2) == [2, 0, 1]
    assert DaySix.rotate_left([0, 1, 2], 3) == [0, 1, 2]
    assert DaySix.rotate_left([0, 1, 2], 4) == [1, 2, 0]
  end

  test "part one dummy" do
    assert DaySix.get_steps(DaySix.detect_infinite_loop([0, 2, 7, 0])) == 5
  end

  test "part one actual" do
    assert DaySix.part_one == 5042
  end

  test "part two dummy" do
    assert DaySix.get_size(DaySix.detect_infinite_loop([0, 2, 7, 0])) == 4
  end
end
