defmodule Day06 do
  @moduledoc """
  Day 6 of the Advent of Code 2021.
  """

  @spec part_one(String.t(), integer()) :: integer()
  def part_one(input, days) do
    fish =
      input
      |> parse_input()
      |> Enum.frequencies()

    initial_counts =
      0..8
      |> Enum.map(fn n -> {n, Map.get(fish, n, 0)} end)
      |> Map.new()

    1..days
    |> Enum.reduce(initial_counts, &simulate_day/2)
    |> Enum.to_list()
    |> Enum.map(fn {_, a} -> a end)
    |> Enum.sum()
  end

  @spec part_two(String.t(), integer()) :: integer()
  def part_two(input, days), do: part_one(input, days)

  @spec parse_input(String.t()) :: any()
  defp parse_input(raw) do
    raw
    |> String.split(",", trim: true)
    |> Enum.map(fn s -> String.to_integer(String.trim(s)) end)
  end

  defp simulate_day(day, counts) do
    counts
  end
end
