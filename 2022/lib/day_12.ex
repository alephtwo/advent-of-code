defmodule Day12 do
  @moduledoc """
  Day 12 of Advent of Code 2022.
  """

  @doc """
  """
  @spec part_one(String.t()) :: number()
  def part_one(input) do
    parse_input(input)
  end

  @doc """
  """
  @spec part_two(String.t()) :: number()
  def part_two(input) do
    parse_input(input)
  end

  defp parse_input(input) do
    input
    |> String.split("\n", trim: true)
  end
end
