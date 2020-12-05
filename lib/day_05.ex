defmodule Day05 do
  @moduledoc """
  Day 5 of Advent of Code 2020.
  """

  @input File.read!("priv/05.txt")

  def part_one do
    parse_input()
    |> Enum.map(&parse_boarding_pass/1)
    |> Enum.map(fn x -> x.seat_id end)
    |> Enum.max()
  end

  def part_two do
    taken_seats =
      parse_input()
      |> Enum.map(&parse_boarding_pass/1)
      |> Enum.map(fn x -> x.seat_id end)
      |> MapSet.new()

    {min, max} = Enum.min_max(taken_seats)
    all_seats = MapSet.new(min..max)

    all_seats
    |> MapSet.difference(taken_seats)
    |> Enum.at(0)
  end

  def parse_boarding_pass(text) do
    # The first 7 characters are to find your row. 
    # The remaining 3 are to find your column.
    {r, c} = String.split_at(text, 7)

    row = follow_row_instructions(r)
    col = follow_col_instructions(c)

    %{
      row: row,
      column: col,
      seat_id: row * 8 + col
    }
  end

  def follow_row_instructions(instructions) do
    binary_space_partition(instructions, 127, "F", "B")
  end

  def follow_col_instructions(instructions) do
    binary_space_partition(instructions, 7, "L", "R")
  end

  defp binary_space_partition(instructions, max, lower, upper) do
    instructions
    |> String.graphemes()
    |> Enum.reduce([0, max], fn instruction, [l, u] ->
      half = div(u - l, 2) + 1

      case instruction do
        ^lower -> [l, u - half]
        ^upper -> [l + half, u]
      end
    end)
    |> Enum.at(0)
  end

  defp parse_input(input \\ @input) do
    input
    |> String.split("\n", trim: true)
  end
end
