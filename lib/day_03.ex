defmodule Day03 do
  @moduledoc """
  Day 3 of the Advent of Code 2021.
  """

  def part_one(input) do
    frequencies = input |> parse_input() |> columnar_frequencies()

    gamma_rate = find_gamma_rate(frequencies)
    epsilon_rate = find_epsilon_rate(frequencies)

    gamma_rate * epsilon_rate
  end

  def part_two(input) do
    input
    |> parse_input
  end

  defp parse_input(raw) do
    raw
    |> String.split("\n", trim: true)
  end

  defp columnar_frequencies(rows) do
    rows
    |> Enum.map(&String.graphemes/1)
    |> Enum.map(fn row -> Enum.map(row, &String.to_integer/1) end)
    |> List.zip()
    |> Enum.map(&Tuple.to_list/1)
    |> Enum.map(&Enum.frequencies/1)
  end

  defp find_gamma_rate(frequencies), do: find_rate(frequencies, &Enum.max_by/2)
  defp find_epsilon_rate(frequencies), do: find_rate(frequencies, &Enum.min_by/2)

  defp find_rate(frequencies, func) do
    frequencies
    |> Enum.map(&Map.to_list/1)
    |> Enum.map(fn col -> func.(col, fn {_, b} -> b end) end)
    |> Enum.map(fn {a, _} -> a end)
    |> Enum.join("")
    |> String.to_integer(2)
  end
end
