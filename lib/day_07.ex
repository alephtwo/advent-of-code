defmodule Day07 do
  @moduledoc """
  Day 7 of Advent of Code 2020.
  """

  @input File.read!("priv/07.txt")

  def part_one(input \\ @input) do
    input
    |> parse_input()
    |> IO.inspect()
  end

  def part_two(input \\ @input), do: :error

  def parse_input(input) do
    input
    |> String.split("\n", trim: true)
    |> Enum.map(&parse_rule/1)
  end

  def parse_rule(text) do
    [type, contents] = String.split(text, " contain ", trim: true)

    %{
      # Remove " bags" because it will appear in everything.
      type: String.replace(type, ~r/ bags?/, ""),
      rules: parse_contents(contents)
    }
  end

  def parse_contents(contents) do
    contents
    |> String.split(", ", trim: true)
    |> Enum.map(&parse_bag/1)
    |> Enum.filter(fn x -> x != :none end)
  end

  def parse_bag(bag) do
    if bag == "no other bags." do
      :none
    else
      regex = ~r/(?<amount>\d+) (?<color>.*?) bags?\.?/
      caps = Regex.named_captures(regex, bag)
      %{color: Map.get(caps, "color"), amount: caps |> Map.get("amount") |> String.to_integer()}
    end
  end
end
