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

  def part_one(source \\ @input) do
    passports = parse_input(source)
    # ignore presence and absence of cid
    required_fields = MapSet.delete(@fields, "cid")

    passports
    |> Enum.filter(fn p ->
      p
      |> Map.keys()
      |> MapSet.new()
      # ignore presence and absence of cid
      |> MapSet.delete("cid")
      |> MapSet.equal?(required_fields)
    end)
    |> Enum.count()
  end

  def part_two(source \\ @input) do
    input = parse_input(source)
    nil
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
