defmodule Day04Test do
  @moduledoc """
  Tests for Day 4 of Advent of Code 2020.
  """
  use ExUnit.Case
  doctest Day04
  @moduletag :finished

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

  @p2_invalid_sample """
  eyr:1972 cid:100
  hcl:#18171d ecl:amb hgt:170 pid:186cm iyr:2018 byr:1926

  iyr:2019
  hcl:#602927 eyr:1967 hgt:170cm
  ecl:grn pid:012533040 byr:1946

  hcl:dab227 iyr:2012
  ecl:brn hgt:182cm pid:021572410 eyr:2020 byr:1992 cid:277

  hgt:59cm ecl:zzz
  eyr:2038 hcl:74454a iyr:2023
  pid:3556412378 byr:2007
  """

  @p2_valid_sample """
  pid:087499704 hgt:74in ecl:grn iyr:2012 eyr:2030 byr:1980
  hcl:#623a2f

  eyr:2029 ecl:blu cid:129 byr:1989
  iyr:2014 pid:896056539 hcl:#a97842 hgt:165cm

  hcl:#888785
  hgt:164cm byr:2001 iyr:2015 cid:88
  pid:545766238 ecl:hzl
  eyr:2022

  iyr:2010 hgt:158cm hcl:#b6652a ecl:blu byr:1944 eyr:2021 pid:093154719
  """

  test "part 1 sample solution" do
    assert Day04.part_one(@sample) == 2
  end

  test "part 1 solution" do
    assert Day04.part_one() == 210
  end

  test "part 2 byr" do
    assert Day04.validate_field("byr", "2002") == true
    assert Day04.validate_field("byr", "2003") == false
  end

  test "part 2 hgt" do
    assert Day04.validate_field("hgt", "60in") == true
    assert Day04.validate_field("hgt", "190cm") == true
    assert Day04.validate_field("hgt", "190in") == false
    assert Day04.validate_field("hgt", "190") == false
  end

  test "part 2 hcl" do
    assert Day04.validate_field("hcl", "#123abc") == true
    assert Day04.validate_field("hcl", "#123abz") == false
    assert Day04.validate_field("hcl", "123abc") == false
  end

  test "part 2 ecl" do
    assert Day04.validate_field("ecl", "brn") == true
    assert Day04.validate_field("ecl", "wat") == false
  end

  test "part 2 pid" do
    assert Day04.validate_field("pid", "000000001") == true
    assert Day04.validate_field("pid", "0123456789") == false
  end

  test "part 2 invalid samples are all considered invalid" do
    passports = Day04.parse_input(@p2_invalid_sample)

    assert Enum.all?(passports, fn p ->
             Day04.validate_required_fields(p) && Day04.validate_field_data(p) == false
           end) == true
  end

  test "part 2 valid samples are all considered valid" do
    passports = Day04.parse_input(@p2_valid_sample)

    assert Enum.all?(passports, fn p ->
             Day04.validate_required_fields(p) && Day04.validate_field_data(p) == true
           end) == true
  end

  test "part 2 solution" do
    # 132 is too high.
    assert Day04.part_two() == nil
  end
end
