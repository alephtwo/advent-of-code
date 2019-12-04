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
end
