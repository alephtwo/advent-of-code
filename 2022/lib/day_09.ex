defmodule Day09 do
  @moduledoc """
  Day 9 of Advent of Code 2022.
  """

  @doc """
  """
  @spec part_one(String.t()) :: number()
  def part_one(input) do
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

  defp parse_input(input) do
    input
    |> String.split("\n", trim: true)
    |> Enum.map(fn s ->
      [direction, amplitude] = String.split(s)
      {direction, String.to_integer(amplitude)}
    end)
  end
end
