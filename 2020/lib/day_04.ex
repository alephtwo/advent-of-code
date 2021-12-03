defmodule Day04 do
  @moduledoc """
  Day 4 of Advent of Code 2020.
  """
  @input File.read!("priv/04.txt")

  @fields MapSet.new([
            "byr",
            "iyr",
            "eyr",
            "hgt",
            "hcl",
            "ecl",
            "pid",
            "cid"
          ])

  @eye_colors MapSet.new([
                "amb",
                "blu",
                "brn",
                "gry",
                "grn",
                "hzl",
                "oth"
              ])

  # ignore presence and absence of cid
  @required_fields MapSet.delete(@fields, "cid")

  def part_one(source \\ @input) do
    passports = parse_input(source)

    passports
    |> Enum.filter(&validate_required_fields/1)
    |> Enum.count()
  end

  def part_two(source \\ @input) do
    passports = parse_input(source)

    passports
    |> Enum.filter(&validate_required_fields/1)
    |> Enum.filter(&validate_field_data/1)
    |> Enum.count()
  end

  def validate_required_fields(passport) do
    passport
    |> Map.keys()
    |> MapSet.new()
    # ignore presence and absence of cid
    |> MapSet.delete("cid")
    |> MapSet.equal?(@required_fields)
  end

  def validate_field_data(passport) do
    Enum.all?(@required_fields, fn f -> validate_field(f, Map.get(passport, f)) end)
  end

  def validate_field("byr", byr) do
    validate_year_between(byr, 1920, 2002)
  end

  def validate_field("iyr", iyr) do
    validate_year_between(iyr, 2010, 2020)
  end

  def validate_field("eyr", eyr) do
    validate_year_between(eyr, 2020, 2030)
  end

  def validate_field("hgt", hgt) do
    cond do
      String.ends_with?(hgt, "cm") -> validate_height_between(hgt, 150, 193)
      String.ends_with?(hgt, "in") -> validate_height_between(hgt, 59, 76)
      true -> false
    end
  end

  def validate_field("hcl", hcl) do
    String.match?(hcl, ~r/#[a-f0-9]{6}/)
  end

  def validate_field("ecl", ecl) do
    MapSet.member?(@eye_colors, ecl)
  end

  def validate_field("pid", pid) do
    String.match?(pid, ~r/^\d{9}$/)
  end

  def validate_year_between(n, min, max) do
    is_year = String.match?(n, ~r/\d{4}/)

    if is_year do
      i = String.to_integer(n)
      i >= min && i <= max
    else
      false
    end
  end

  def validate_height_between(hgt, min, max) do
    # Drop the last two characters
    regex = ~r/(?<height>\d+)(cm|in)/
    captures = Regex.named_captures(regex, hgt)

    height = Map.get(captures, "height") |> String.to_integer()
    height >= min && height <= max
  end

  def parse_input(input) do
    input
    |> String.split("\n\n", trim: true)
    |> Enum.map(&String.replace(&1, "\n", " "))
    |> Enum.map(&String.trim/1)
    |> Enum.map(&parse_line_to_map/1)
  end

  def parse_line_to_map(line) do
    line
    |> String.split(" ", trim: true)
    |> Enum.map(&String.split(&1, ":"))
    |> Map.new(fn [k, v] -> {k, v} end)
  end
end
