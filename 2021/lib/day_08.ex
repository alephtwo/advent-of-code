defmodule Day08 do
  @moduledoc """
  Day 8 of the Advent of Code 2021.
  """
  # Digits with known lengths.
  # length => digit
  @known_lengths %{
    2 => 1,
    4 => 4,
    3 => 7,
    7 => 8
  }

  @spec part_one(String.t()) :: integer()
  def part_one(input) do
    input
    |> parse_input()
    |> Enum.flat_map(&Map.get(&1, :output))
    |> Enum.map(fn x -> Map.get(@known_lengths, Enum.count(x)) end)
    |> Enum.filter(fn x -> x != nil end)
    |> Enum.count()
  end

  @spec part_two(String.t()) :: integer()
  def part_two(input) do
    parse_input(input)
  end

  defp parse_input(raw) do
    raw
    |> String.split("\n", trim: true)
    |> Enum.map(&parse_signal_line/1)
  end

  defp parse_signal_line(line) do
    [signals, output] =
      line
      |> String.split(" | ", trim: true)
      |> Enum.map(&convert_tokens_to_sets/1)

    %{signals: signals, output: output}
  end

  defp convert_tokens_to_sets(string) do
    string
    |> String.split(" ", trim: true)
    |> Enum.map(&MapSet.new(String.graphemes(&1)))
  end
end
