defmodule DayFourTest do
  use ExUnit.Case
  doctest DayFour

  test "part one dummy valid" do
    assert DayFour.contains_no_duplicate_words("aa bb cc dd ee")
  end

  test "part one dummy invalid (duplicate aa)" do
    assert !DayFour.contains_no_duplicate_words("aa bb cc dd aa")
  end

  test "part one dummy valid (similar tokens)" do
    assert DayFour.contains_no_duplicate_words("aa bb cc dd aaa")
  end

  test "part one actual" do
    assert DayFour.part_one(DayFour.parse_file()) == 451
  end
end
