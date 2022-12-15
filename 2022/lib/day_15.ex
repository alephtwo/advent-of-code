defmodule Day15 do
  @moduledoc """
  Day 15 of Advent of Code 2022.
  """

  defmodule Sensor do
    defstruct [:closest_beacon]
  end

  defmodule Beacon do
    defstruct []
  end

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

      {
        {String.to_integer(sx), String.to_integer(sy)},
        {String.to_integer(cbx), String.to_integer(cby)}
      }
    end)
    |> place_objects()
  end

  defp place_objects(lines) do
    Enum.reduce(lines, %{}, fn {{sx, sy}, {cbx, cby}}, coords ->
      coords
      |> Map.put({sx, sy}, %Sensor{closest_beacon: {cbx, cby}})
      |> Map.put({cbx, cby}, %Beacon{})
    end)
  end
end
