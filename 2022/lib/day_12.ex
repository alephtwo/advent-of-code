defmodule Day12 do
  @moduledoc """
  Day 12 of Advent of Code 2022.
  """

  @doc """
  """
  @spec part_one(String.t()) :: number()
  def part_one(input) do
    grid = parse_input(input)
    %{"S" => start, "E" => finish} = identify_key_locations(grid)
  end

  @doc """
  """
  @spec part_two(String.t()) :: number()
  def part_two(input) do
    grid = parse_input(input)
  end

  defp parse_input(input) do
    input
    |> String.split("\n", trim: true)
    |> Enum.with_index()
    |> Enum.flat_map(fn {line, y} ->
      line
      |> String.graphemes()
      |> Enum.with_index()
      |> Enum.map(fn {point, x} -> {{x, y}, point} end)
    end)
    |> Map.new()
  end

  @key_locations ["S", "E"]
  defp identify_key_locations(grid) do
    grid
    |> Map.to_list()
    |> Enum.filter(fn {_, c} -> Enum.member?(@key_locations, c) end)
    |> Enum.map(fn {point, c} -> {c, point} end)
    |> Map.new()
  end
end
