defmodule Day01Test do
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
    assert Day01.calculate_fuel_from_mass(100_756) == 33583
  end

  test "part one" do
    assert Day01.part_one() == 3_342_946
  end
end
