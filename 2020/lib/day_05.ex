defmodule Day05 do
  @moduledoc """
  Day 5 of Advent of Code 2020.
  """

  @input File.read!("priv/05.txt")

  def part_one, do: Enum.max(get_seat_ids())

  def part_two do
    taken_seats = MapSet.new(get_seat_ids())

    {min, max} = Enum.min_max(taken_seats)

    MapSet.new(min..max)
    |> MapSet.difference(taken_seats)
    |> Enum.at(0)
  end

  defp get_seat_ids() do
    @input
    |> String.split("\n", trim: true)
    |> Enum.map(&parse_seat_id/1)
  end

  def parse_seat_id(text) do
    # The first 7 characters are to find your row. 
    # The remaining 3 are to find your column.
    {r, c} = String.split_at(text, 7)
    partition(r) * 8 + partition(c)
  end

  def partition(instructions) do
    # The instructions can be converted directly to their
    # value by interpreting them as base 2 (with some fiddling).
    instructions
    |> String.replace(~r/(F|L)/, "0")
    |> String.replace(~r/(B|R)/, "1")
    |> String.to_integer(2)
  end
end
