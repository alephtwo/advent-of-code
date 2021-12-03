defmodule Day03 do
  @moduledoc """
  Day 3 of the Advent of Code 2021.
  """

  def part_one(input) do
    frequencies = input |> parse_input() |> calculate_frequency_in_column()

    gamma_rate = find_rate(frequencies, &Enum.max_by/2)
    epsilon_rate = find_rate(frequencies, &Enum.min_by/2)

    gamma_rate * epsilon_rate
  end

  def part_two(input) do
    rows = input |> parse_input()

    o2_rating = process_rows(rows, &Enum.max_by/3, fn a, b -> a > b end)
    co2_rating = process_rows(rows, &Enum.min_by/3, fn a, b -> a <= b end)

    o2_rating * co2_rating
  end

  defp parse_input(raw) do
    raw
    |> String.split("\n", trim: true)
    |> Enum.map(&String.graphemes/1)
    |> Enum.map(fn row -> Enum.map(row, &String.to_integer/1) end)
  end

  defp calculate_frequency_in_column(rows) do
    rows
    |> List.zip()
    |> Enum.map(&Tuple.to_list/1)
    |> Enum.map(&Enum.frequencies/1)
  end

  defp find_rate(frequencies, func) do
    frequencies
    |> Enum.map(&Map.to_list/1)
    |> Enum.map(fn col -> func.(col, fn {_, b} -> b end) end)
    |> Enum.map(fn {a, _} -> a end)
    |> Enum.join()
    |> String.to_integer(2)
  end

  defp process_rows(rows, func, sorter), do: process_rows(rows, 0, func, sorter)

  defp process_rows([a], _index, _func, _sorter) do
    a
    |> Enum.join()
    |> String.to_integer(2)
  end

  defp process_rows(rows, index, func, sorter) do
    {bit_criteria, _} =
      rows
      |> Enum.map(fn row -> Enum.at(row, index) end)
      |> Enum.frequencies()
      |> func.(fn {_, b} -> b end, sorter)

    rows
    |> Enum.filter(fn row -> Enum.at(row, index) == bit_criteria end)
    |> process_rows(index + 1, func, sorter)
  end
end
