defmodule Day14 do
  @moduledoc """
  Day 14 of Advent of Code 2022.
  """

  @doc """
  """
  @spec part_one(String.t()) :: number()
  def part_one(input) do
    lines = parse_input(input)
    {left, right} = find_left_right(lines)
    bottom = find_bottom(lines)

    cave = Enum.reduce(lines,  build_empty_matrix(left, right, bottom), &draw_line/2)

    drop_sand(cave)
  end

  @doc """
  """
  @spec part_two(String.t()) :: number()
  def part_two(input) do
    input
    |> parse_input()
    |> IO.inspect()
  end

  defp drop_sand(cave) do
    cave
  end

  defp parse_input(input) do
    input
    |> String.split("\n", trim: true)
    |> Enum.flat_map(&parse_line/1)
  end

  defp parse_line(line) do
    line
    |> String.split(" -> ", trim: true)
    |> Enum.map(&parse_coords/1)
    |> Enum.chunk_every(2, 1, :discard)
  end

  defp parse_coords(string) do
    string
    |> String.split(",")
    |> Enum.map(&String.to_integer/1)
    |> then(fn [x, y] -> {x, y} end)
  end

  defp find_left_right(lines) do
    lines
    |> Enum.flat_map(fn [{x1, _}, {x2, _}] -> [x1, x2] end)
    |> Enum.min_max()
  end

  defp find_bottom(lines) do
    lines
    |> Enum.flat_map(fn [{_, y1}, {_, y2}] -> [y1, y2] end)
    |> Enum.max()
  end

  defp build_empty_matrix(left, right, bottom) do
    1..bottom
    |> Enum.flat_map(fn y -> Enum.map(left..right, fn x -> {{x, y}, :air} end) end)
    |> Map.new()
  end

  # vertical lines
  defp draw_line([{x, y1}, {x, y2}], matrix) do
    Enum.reduce(y1..y2, matrix, fn y, m -> Map.put(m, {x, y}, :rock) end)
  end

  # horizontal lines
  defp draw_line([{x1, y}, {x2, y}], matrix) do
    Enum.reduce(x1..x2, matrix, fn x, m -> Map.put(m, {x, y}, :rock) end)
  end
end
