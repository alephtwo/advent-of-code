defmodule Day02 do
  @moduledoc """
  Day Two of Advent of Code 2018.
  """
  @external_resource "priv/02.txt"
  @input File.read!("priv/02.txt")

  def solve do
    IO.puts(part_one(parse_input()))
    IO.puts(part_two(parse_input()))
  end

  def part_one(input) when is_list(input) do
  end

  def part_two(input) when is_list(input) do
  end

  def parse_input do
    String.split(@input, "\n", trim: true)
  end
end
