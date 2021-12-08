defmodule Day08 do
  @moduledoc """
  Day 8 of the Advent of Code 2021.
  """

  @spec part_one(String.t()) :: integer()
  def part_one(input) do
    input
    |> parse_input()
    |> Enum.flat_map(&Map.get(&1, :output))
    |> Enum.map(&transform_to_number_by_length/1)
    |> Enum.filter(fn x -> x != :not_matched end)
    |> Enum.count()
  end

  @spec part_two(String.t()) :: integer()
  def part_two(input) do
    parse_input(input)
  end

  defp parse_input(raw) do
    dissect_line = fn line ->
      [signals, output] =
        line
        |> String.split(" | ", trim: true)
        |> Enum.map(&String.split(&1, " ", trim: true))

      %{signals: signals, output: output}
    end

    raw
    |> String.split("\n", trim: true)
    |> Enum.map(dissect_line)
  end

  defp transform_to_number_by_length(string) do
    case String.length(string) do
      2 -> 1
      3 -> 7
      4 -> 4
      7 -> 8
      _ -> :not_matched
    end
  end
end
