defmodule Day05 do
  @moduledoc """
  Day 5 of the Advent of Code 2021.
  """
  @line_regex ~r/(\d+),(\d+) -> (\d+),(\d+)/

  def part_one(input) do
    input
    |> parse_input()
  end

  def part_two(input) do
    input
    |> parse_input()
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
end
