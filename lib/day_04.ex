defmodule Day04 do
  @moduledoc """
  Day Four of Advent of Code 2018.
  """
  @external_resource "priv/04.txt"
  @input File.read!("priv/04.txt")

  def part_one, do: part_one(parse_input())

  def part_one(_input) do
  end

  def part_two, do: part_two(parse_input())

  def part_two(_input) do
  end

  defp parse_input do
    String.split(@input, "\n", trim: true)
  end
end
