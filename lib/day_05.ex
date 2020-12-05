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

  def parse_boarding_pass(text) do
    # The first 7 characters are to find your row. 
    # The remaining 3 are to find your column.
    {r, c} = String.split_at(text, 7)

    row = resolve_binary_partition(r)
    col = resolve_binary_partition(c)

    %{row: row, column: col, seat_id: row * 8 + col}
  end

  def resolve_binary_partition(instructions) do
    # The instructions can be converted directly to their
    # value by interpreting them as base 2 (with some fiddling).
    instructions
    |> String.replace(~r/(F|L)/, "0")
    |> String.replace(~r/(B|R)/, "1")
    |> String.to_integer(2)
  end

  defp get_seat_ids(input \\ @input) do
    input
    |> String.split("\n", trim: true)
    |> Enum.map(&parse_boarding_pass/1)
    |> Enum.map(fn x -> x.seat_id end)
  end
end
