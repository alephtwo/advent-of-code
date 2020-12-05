defmodule Day04Test do
  @moduledoc """
  Tests for Day 4 of Advent of Code 2020.
  """
  use ExUnit.Case
  doctest Day04

  @sample """
  ecl:gry pid:860033327 eyr:2020 hcl:#fffffd
  byr:1937 iyr:2017 cid:147 hgt:183cm

  iyr:2013 ecl:amb cid:350 eyr:2023 pid:028048884
  hcl:#cfa07d byr:1929

  hcl:#ae17e1 iyr:2013
  eyr:2024
  ecl:brn pid:760753108 byr:1931
  hgt:179cm

  hcl:#cfa07d eyr:2025 pid:166559648
  iyr:2011 ecl:brn hgt:59in
  """

  test "part 1 sample solution" do
    assert Day04.part_one(@sample) == 2
  end

  test "part 1 solution" do
    assert Day04.part_one() == 210
  end

  test "part 2 solution" do
    assert Day04.part_two() == nil
  end
end
