defmodule Day09 do
  @moduledoc """
  Day 9 of Advent of Code 2020.
  """
  @input File.read!("priv/09.txt")

  def part_one(input \\ @input, bandwidth \\ 25) do
    input
    |> parse_input()
    |> determine_vulnerability(bandwidth)
  end

  def part_two(input \\ @input), do: input

  defp parse_input(input) do
    input
    |> String.split("\n", trim: true)
    |> Enum.map(&String.to_integer/1)
  end

  defp determine_vulnerability(input, bandwidth) do
    length = Enum.count(input)

    # Use this range as the indexes to scan in the array.
    {number, _} =
      bandwidth..(length - 1)
      # Associate each index with its value and the list of values that
      # must be checked before it.
      |> Stream.map(fn i -> {Enum.at(input, i), Enum.slice(input, i - bandwidth, i)} end)
      |> Stream.filter(fn x -> !confirm_valid_number(x) end)
      # Grab the very first.
      |> Stream.take(1)
      |> Enum.at(0)

    number
  end

  defp confirm_valid_number({number, preamble}) do
    indexed_preamble = Enum.with_index(preamble)

    # Build a list of pairs in the preamble.
    pairs = for {x, ix} <- indexed_preamble, {y, iy} <- indexed_preamble, ix != iy, do: [x, y]

    pairs
    |> Enum.map(&Enum.sum/1)
    |> MapSet.new()
    |> MapSet.member?(number)
  end
end
