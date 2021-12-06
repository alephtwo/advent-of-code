defmodule Day06 do
  @moduledoc """
  Day 6 of the Advent of Code 2021.
  """
  @life_cycle 0..8

  @spec part_one(String.t(), integer()) :: integer()
  def part_one(input, days \\ 80) do
    fish =
      input
      |> parse_input()
      |> Enum.frequencies()

    initial_counts =
      @life_cycle
      |> Enum.map(fn n -> {n, Map.get(fish, n, 0)} end)
      |> Map.new()

    1..days
    |> Enum.reduce(initial_counts, &simulate_day/2)
    |> Enum.to_list()
    |> Enum.map(fn {_, a} -> a end)
    |> Enum.sum()
  end

  @spec part_two(String.t(), integer()) :: integer()
  def part_two(input, days \\ 256), do: part_one(input, days)

  @spec parse_input(String.t()) :: any()
  defp parse_input(raw) do
    raw
    |> String.split(",", trim: true)
    |> Enum.map(fn s -> String.to_integer(String.trim(s)) end)
  end

  defp simulate_day(_day, counts) do
    zeroes = Map.get(counts, 0)

    counts
    |> Map.delete(0)
    |> Enum.map(fn {n, d} -> {n - 1, d} end)
    |> Map.new()
    |> Map.put(8, zeroes)
    |> Map.update!(6, fn x -> x + zeroes end)
  end
end
