defmodule DayOne do
  @moduledoc """
  Day One of Advent of Code 2018.
  """
  @external_resource "priv/01.txt"
  @input File.read!("priv/01.txt")

  def solve do
    IO.puts(part_one(parse_input()))
    IO.puts(part_two(parse_input()))
  end

  @doc """
  Day One, Part One.
  Accepts input as a list and returns the sum of all values.
  """
  def part_one(input) when is_list(input), do: Enum.sum(input)

  @doc """
  Repeat the cycle until we find a duplicate frequency.
  TODO: Boy, this sure is inefficient. But all the tests pass, so ¯\_(ツ)_/¯
  """
  def part_two(input) when is_list(input) do
    input
    |> Stream.cycle()
    |> Enum.reduce_while([0], fn n, accum ->
      next_freq = Enum.at(accum, 0) + n

      if Enum.member?(accum, next_freq) do
        {:halt, next_freq}
      else
        {:cont, [next_freq | accum]}
      end
    end)
  end

  def parse_input do
    @input
    |> String.split("\n", trim: true)
    |> Enum.map(&String.to_integer(&1))
  end
end
