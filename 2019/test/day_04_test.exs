defmodule Day04Test do
  @moduledoc """
  Tests for Day 4 of Advent of Code 2019.
  """
  use ExUnit.Case
  doctest Day04

  test "pass: never decreases, double digit" do
    assert Day04.passes_criteria("111111") == true
  end

  test "fail: decreasing digits" do
    assert Day04.passes_criteria("223450") == false
  end

  test "fail: no double" do
    assert Day04.passes_criteria("123789") == false
  end

  test "part one solution" do
    assert Day04.part_one() == 910
  end

  test "repeated digits are exactly two digits long" do
    assert Day04.passes_strict_criteria("112233") == true
  end

  test "no large groups of repeated digits" do
    assert Day04.passes_strict_criteria("123444") == false
  end

  test "large groups, but there is a double group" do
    assert Day04.passes_strict_criteria("111122") == true
  end

  test "part two solution" do
    assert Day04.part_two() == 598
  end
end
