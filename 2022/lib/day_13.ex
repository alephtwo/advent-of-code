defmodule Day13 do
  @moduledoc """
  Day 13 of Advent of Code 2022.
  """

  @doc """
  """
  @spec part_one(String.t()) :: number()
  def part_one(input) do
    input
    |> parse_input()
    |> Enum.map(fn {left, right} -> compare(left, right) end)
    |> IO.inspect(charlists: :as_lists)
  end

  @doc """
  """
  @spec part_two(String.t()) :: number()
  def part_two(input) do
    input
    |> parse_input()
    |> IO.inspect(charlists: :as_lists)
  end

  # if both are empty - catch and return true
  defp compare([], []), do: true
  # right side runs out of items, inputs out of order
  defp compare(_left, []), do: false
  # left side runs out of items, inputs are in order
  defp compare([], _right), do: true
  # otherwise look at the first thing in each list
  defp compare([left | _], [right | _]) do
    false
  end

  defp parse_input(input) do
    input
    |> String.split("\n\n", trim: true)
    |> Enum.map(&String.split(&1, "\n", trim: true))
    |> Enum.map(fn [a, b] ->
      {first, []} = Code.eval_string(a)
      {second, []} = Code.eval_string(b)
      {first, second}
    end)
  end
end
