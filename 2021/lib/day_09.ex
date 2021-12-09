defmodule Day09 do
  @moduledoc """
  Day 9 of the Advent of Code 2021.
  """
  @spec part_one(String.t()) :: integer()
  def part_one(input) do
    matrix =
      input
      |> parse_input()
      |> Matrix.index_matrix()

    matrix
    |> Enum.reduce(%{matrix: matrix, minima: []}, &get_local_minima/2)
    |> Map.get(:minima)
    |> List.flatten()
    # calculate risk factor
    |> Enum.map(&(&1 + 1))
    |> Enum.sum()
  end

  @spec part_two(String.t()) :: integer()
  def part_two(input) do
    parse_input(input)
  end

  defp parse_input(raw) do
    raw
    |> String.split("\n", trim: true)
    |> Enum.map(fn row -> row |> String.graphemes() |> Enum.map(&String.to_integer/1) end)
  end

  defp get_local_minima({y, row}, acc) do
    row_minima =
      row
      |> Enum.reduce(%{matrix: acc.matrix, y: y, minima: []}, &get_local_minima_for_row/2)
      |> Map.get(:minima)

    Map.update!(acc, :minima, fn a -> [row_minima | a] end)
  end

  defp get_local_minima_for_row({x, value}, acc) do
    top = Matrix.get_coordinate(acc.matrix, x, acc.y - 1)
    right = Matrix.get_coordinate(acc.matrix, x + 1, acc.y)
    bottom = Matrix.get_coordinate(acc.matrix, x, acc.y + 1)
    left = Matrix.get_coordinate(acc.matrix, x - 1, acc.y)

    neighbors = Enum.filter([top, right, bottom, left], &(&1 != :not_found))

    if value < Enum.min(neighbors) do
      Map.update!(acc, :minima, fn a -> [value | a] end)
    else
      acc
    end
  end
end
