defmodule Day15 do
  @moduledoc """
  Day 15 of Advent of Code 2022.
  """

  @doc """
  """
  @spec part_one(String.t(), integer()) :: number()
  def part_one(input, _y) do
    input
    |> parse_input()
    |> IO.inspect()
  end

  @doc """
  """
  @spec part_two(String.t()) :: number()
  def part_two(input) do
    input
    |> parse_input()
    |> IO.inspect()
  end

  @line_regex ~r/Sensor at x=(-?\d+), y=(-?\d+): closest beacon is at x=(-?\d+), y=(-?\d+)/
  defp parse_input(input) do
    input
    |> String.split("\n", trim: true)
    |> Enum.map(fn line ->
      [_, sx, sy, cbx, cby] = Regex.run(@line_regex, line)
      {{sx, sy}, {cbx, cby}}
    end)
  end
end
