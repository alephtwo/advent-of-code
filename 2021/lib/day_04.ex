defmodule Day04 do
  @moduledoc """
  Day 4 of the Advent of Code 2021.
  """

  def part_one(input) do
    input
    |> parse_input()
  end

  def part_two(input) do
    input
    |> parse_input()
  end

  defp parse_input(raw) do
    [first | rest] = String.split(raw, "\n\n", trim: true)

    draw_order =
      first
      |> String.split(",", trim: true)
      |> Enum.map(&String.to_integer/1)

    boards =
      rest
      |> Enum.map(fn b -> String.split(b, "\n", trim: true) end)
      |> Enum.map(&parse_board/1)

    %{draw_order: draw_order, boards: boards}
  end

  defp parse_board(raw) do
    raw
    |> Enum.map(fn r ->
      String.split(r, " ", trim: true)
      |> Enum.map(&String.to_integer/1)
    end)
  end
end
