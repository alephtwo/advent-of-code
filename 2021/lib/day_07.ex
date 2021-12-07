defmodule Day07 do
  @moduledoc """
  Day 7 of the Advent of Code 2021.
  """

  @spec part_one(String.t()) :: integer()
  def part_one(input) do
    initial_positions = parse_input(input)
    best_position = find_median(initial_positions)
    cost_to_align_on_position(initial_positions, best_position)
  end

  @spec part_two(String.t()) :: integer()
  def part_two(input) do
    initial_positions = parse_input(input)

    {leftmost, rightmost} = Enum.min_max(initial_positions)

    leftmost..rightmost
    |> Enum.map(fn p -> expensive_cost_to_align_on_position(initial_positions, p) end)
    |> Enum.min()
  end

  defp parse_input(raw) do
    raw
    |> String.trim()
    |> String.split(",", trim: true)
    |> Enum.map(&String.to_integer/1)
  end

  defp find_median(list) do
    list
    |> Enum.sort()
    |> Enum.at(div(length(list), 2))
  end

  defp cost_to_align_on_position(list, position) do
    list
    |> Enum.map(fn p -> abs(p - position) end)
    |> Enum.sum()
  end

  def expensive_cost_to_align_on_position(list, position) do
    list
    |> Enum.map(fn p ->
      distance = abs(p - position)
      round((Integer.pow(distance, 2) + distance) / 2)
    end)
    |> Enum.sum()
  end
end
