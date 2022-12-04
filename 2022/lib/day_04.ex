defmodule Day04 do
  @moduledoc """
  Day 4 of Advent of Code 2022.
  """

  @doc """
  """
  @spec part_one(String.t()) :: number()
  def part_one(input) do
    input
    |> parse_input()
    |> Enum.filter(fn [a, b] -> MapSet.subset?(a, b) || MapSet.subset?(b, a) end)
    |> Enum.count()
  end

  @doc """
  """
  @spec part_two(String.t()) :: number()
  def part_two(input) do
    input
    |> parse_input()
    |> Enum.filter(fn [a, b] -> MapSet.intersection(a, b) |> Enum.count() != 0 end)
    |> Enum.count()
  end

  defp parse_input(input) do
    input
    |> String.split("\n", trim: true)
    |> Enum.map(&parse_line/1)
  end

  defp parse_line(string) do
    string
    |> String.split(",")
    |> Enum.map(fn s ->
      [first, last] = s |> String.split("-") |> Enum.map(&String.to_integer/1)
      MapSet.new(first..last)
    end)
  end
end
