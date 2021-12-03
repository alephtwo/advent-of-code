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

  test "part two dummy valid" do
    assert DayFour.contains_no_anagrams("abcde fghij")
  end

  test "part two dummy invalid" do
    assert !DayFour.contains_no_anagrams("abcde xyz ecdab")
  end

  test "part two dummy valid - all characters must be used in an anagram" do
    assert DayFour.contains_no_anagrams("a ab abc abd abf abj")
  end

  test "part two dummy valid - ioioioio" do
    assert DayFour.contains_no_anagrams("iiii oiii ooii oooi oooo")
  end

  test "part two dummy invalid - ioioioio" do
    assert !DayFour.contains_no_anagrams("oiii ioii iioi iiio")
  end

  test "part two actual" do
    assert DayFour.part_two(DayFour.parse_file()) == 223
  end
end
