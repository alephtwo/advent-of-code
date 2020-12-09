defmodule Day09 do
  @moduledoc """
  Day 9 of Advent of Code 2020.
  """
  @input File.read!("priv/09.txt")

  def part_one(input \\ @input, bandwidth \\ 25) do
    input
    |> parse_input()
    |> determine_vulnerability(bandwidth)
  end

  def part_two(input \\ @input), do: input

  defp parse_input(input) do
    input
    |> String.split("\n", trim: true)
    |> Enum.map(&String.to_integer/1)
  end

  defp determine_vulnerability(input, bandwidth) do
    input
  end
end
