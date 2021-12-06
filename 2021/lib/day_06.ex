defmodule Day06 do
  @moduledoc """
  Day 6 of the Advent of Code 2021.
  """

  @spec part_one(String.t(), integer()) :: integer()
  def part_one(input, days) do
    initial = parse_input(input)

    1..days
    |> Enum.reduce(initial, &simulate_day/2)
    |> Enum.count()
  end

  @spec part_two(String.t(), integer()) :: integer()
  def part_two(input, days), do: part_one(input, days)

  @spec parse_input(String.t()) :: any()
  defp parse_input(raw) do
    raw
    |> String.split(",", trim: true)
    |> Enum.map(fn s -> String.to_integer(String.trim(s)) end)
  end

  defp simulate_day(day, fish) do
    IO.inspect(day)
    Enum.flat_map(fish, fn f ->
      case f do
        0 -> [6, 8]
        x -> [x - 1]
      end
    end)
  end
end
