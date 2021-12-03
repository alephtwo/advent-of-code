defmodule Day01Test do
  @moduledoc """
  Tests for Day 1 of Advent of Code 2019.
  """
  use ExUnit.Case
  doctest Day01

  test "mass 12" do
    assert Day01.calculate_fuel_from_mass(12) == 2
  end

  test "mass 14" do
    assert Day01.calculate_fuel_from_mass(14) == 2
  end

  test "mass 1969" do
    assert Day01.calculate_fuel_from_mass(1969) == 654
  end

  test "mass 100756" do
    assert Day01.calculate_fuel_from_mass(100_756) == 33_583
  end

  test "part one solution" do
    assert Day01.part_one() == 3_342_946
  end

  test "mass 14 part 2" do
    assert Day01.calculate_fuel_recursively(14) == 2
  end

  test "mass 1969 part 2" do
    assert Day01.calculate_fuel_recursively(1969) == 966
  end

  test "mass 100756 part 2" do
    assert Day01.calculate_fuel_recursively(100_756) == 50_346
  end

  test "part two solution" do
    assert Day01.part_two() == 5_011_553
  end
end
