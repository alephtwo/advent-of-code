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
    1
  end

  def follow_col_instructions(instructions) do
    1
  end

  defp parse_input(input \\ @input) do
    @input
    |> String.split("\n", trim: true)
  end
end
