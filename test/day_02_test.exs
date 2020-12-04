defmodule Day02Test do
  @moduledoc """
  Tests for Day 2 of Advent of Code 2020.
  """
  use ExUnit.Case
  doctest Day02
  @moduletag :finished

  @sample [
    "1-3 a: abcde",
    "1-3 b: cdefg",
    "2-9 c: ccccccccc"
  ]

  test "part 1 example count_valid_passwords" do
    assert Day02.count_valid_passwords(@sample) == 2
  end

  test "part 1 example valid passwords" do
    assert Day02.password_is_valid("1-3 a: abcde") == true
    assert Day02.password_is_valid("2-9 c: ccccccccc") == true
  end

  test "part 1 example invalid password" do
    assert Day02.password_is_valid("1-3 b: cdefg") == false
  end

  test "part 1 solution" do
    assert Day02.part_one() == 600
  end

  test "part 2 example count_valid_passwords" do
    assert Day02.count_valid_tcas_passwords(@sample) == 1
  end

  test "part 2 example valid passwords" do
    assert Day02.tcas_password_is_valid("1-3 a: abcde") == true
  end

  test "part 2 example invalid password" do
    assert Day02.tcas_password_is_valid("1-3 b: cdefg") == false
    assert Day02.tcas_password_is_valid("2-9 c: ccccccccc") == false
  end

  test "part 2 solution" do
    assert Day02.part_two() == 245
  end
end
