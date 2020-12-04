defmodule Day03 do
  @moduledoc """
  Day 3 of Advent of Code 2020.
  """
  @input File.read!("priv/03.txt")

  def part_one do
  end

  def part_two do
  end

  def parse_map(text) do
    text
    |> String.split("\n", trim: true)
    |> Enum.map(&String.graphemes/1)
  end
end
