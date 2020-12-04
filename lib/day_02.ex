defmodule Day02 do
  @moduledoc """
  Day 2 of Advent of Code 2020.
  """
  @input File.read!("priv/02.txt")
         |> String.split("\n", trim: true)

  @regex ~r/^(?<low>\d+)-(?<high>\d+) (?<char>\w): (?<password>.*?)$/

  def part_one do
    count_valid_passwords(@input)
  end

  def part_two do
    count_valid_tcas_passwords(@input)
  end

  def count_valid_passwords(passwords) do
    passwords
    |> Enum.filter(&password_is_valid/1)
    |> Enum.count()
  end

  def password_is_valid(password) do
    spec = parse_password_line(password)

    count =
      spec.password
      |> String.graphemes()
      |> Enum.count(&(&1 == spec.character))

    count >= spec.low && count <= spec.high
  end

  def count_valid_tcas_passwords(passwords) do
    passwords
    |> Enum.filter(&tcas_password_is_valid/1)
    |> Enum.count()
  end

  def tcas_password_is_valid(password) do
    spec = parse_password_line(password)
    chars = String.graphemes(spec.password)

    low_matches = Enum.at(chars, spec.low - 1) == spec.character
    high_matches = Enum.at(chars, spec.high - 1) == spec.character

    low_matches != high_matches
  end

  def parse_password_line(password) do
    caps = Regex.named_captures(@regex, password)

    %{
      low: Map.get(caps, "low") |> String.to_integer(),
      high: Map.get(caps, "high") |> String.to_integer(),
      character: Map.get(caps, "char"),
      password: Map.get(caps, "password")
    }
  end
end
