defmodule Day06 do
  @moduledoc """
  Day 6 of Advent of Code 2020.
  """

  @input File.read!("priv/06.txt")

  def part_one(input \\ @input) do
    input
    |> parse_input()
    |> IO.inspect()
  end

  def part_two, do: :error

  def parse_input(input) do
    input
    |> String.split("\n\n", trim: true)
    |> Enum.map(&String.split(&1, "\n", trim: true))
  end
end
