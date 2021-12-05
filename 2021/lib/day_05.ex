defmodule Day05 do
  @moduledoc """
  Day 5 of the Advent of Code 2021.
  """

  @line_regex ~r/(\d+),(\d+) -> (\d+),(\d+)/

  def part_one(input) do
    input
    |> parse_input()
    |> Enum.filter(fn line -> is_horizontal(line) or is_vertical(line) end)
    |> draw_lines()
    |> Enum.frequencies()
    |> Enum.filter(fn {_, freq} -> freq > 1 end)
    |> Enum.count()
  end

  def part_two(input) do
    input
    |> parse_input()
    |> draw_lines()
    |> Enum.frequencies()
    |> Enum.filter(fn {_, freq} -> freq > 1 end)
    |> Enum.count()
  end

  defp parse_input(raw) do
    raw
    |> String.split("\n", trim: true)
    |> Enum.map(&parse_line/1)
  end

  defp parse_line(line) do
    [_ | caps] = Regex.run(@line_regex, line)
    [x1, y1, x2, y2] = Enum.map(caps, &String.to_integer/1)
    %{start: {x1, y1}, end: {x2, y2}}
  end

  defp is_horizontal(%{start: {_, y1}, end: {_, y2}}), do: y1 == y2
  defp is_vertical(%{start: {x1, _}, end: {x2, _}}), do: x1 == x2

  defp draw_lines(lines), do: Enum.flat_map(lines, &draw_line/1)

  defp draw_line(line = %{start: {x1, y1}, end: {x2, y2}}) do
    cond do
      is_horizontal(line) -> Enum.map(x1..x2, fn x -> {x, y1} end)
      is_vertical(line) -> Enum.map(y1..y2, fn y -> {x1, y} end)
      true -> Enum.zip(x1..x2, y1..y2)
    end
  end
end
