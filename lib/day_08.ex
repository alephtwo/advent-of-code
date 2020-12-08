defmodule Day08 do
  @moduledoc """
  Day 8 of Advent of Code 2020.
  """
  @input File.read!("08.txt")

  def part_one(input \\ @input), do: input

  def part_two(input \\ @input), do: input

  defp parse_input(input) do
    input
    |> String.split("\n", trim: true)
  end
end
