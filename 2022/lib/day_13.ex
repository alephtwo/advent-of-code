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
    |> Enum.with_index(1)
    |> Enum.map(fn {{left, right}, i} ->
      {:halt, v} = compare(left, right)
      {v, i}
    end)
    |> Enum.filter(fn {b, _} -> b end)
    |> Enum.map(fn {_, i} -> i end)
    |> Enum.sum()
  end

  @doc """
  """
  @spec part_two(String.t()) :: number()
  def part_two(input) do
    input
    |> parse_input()
    |> Enum.flat_map(fn {left, right} -> [left, right] end)
    |> Enum.concat([[[2]], [[6]]])
    |> Enum.sort(fn a, b ->
      {:halt, v} = compare(a, b)
      v
    end)
    |> Enum.with_index(1)
    |> Enum.filter(fn {p, _} -> p == [[6]] or p == [[2]] end)
    |> Enum.map(fn {_, i} -> i end)
    |> Enum.product()
  end

  # assume the data is NOT in order, return true if it does at any point.
  # if both lists run out of items, we can't make a determination
  defp compare([], []), do: :continue
  # if the left list runs out of items first, the inputs are in the right order
  defp compare([], right) when length(right) > 0, do: {:halt, true}
  # if the right list runs out of items first, the inputs are OUT of order
  defp compare(left, []) when length(left) > 0, do: {:halt, false}
  # if both values are integers, the lower integer should come first
  defp compare(left, right) when is_integer(left) and is_integer(right) do
    cond do
      # if the left integer is lower than the right integer, ordered correctly
      left < right -> {:halt, true}
      # if the left integer is higher than the right integer, out of order
      left > right -> {:halt, false}
      # if they are equivalent, continue checking input
      left == right -> :continue
    end
  end

  # if both inputs are lists,
  defp compare(left, right) when is_list(left) and is_list(right) do
    case compare(hd(left), hd(right)) do
      :continue -> compare(tl(left), tl(right))
      {:halt, value} -> {:halt, value}
    end
  end

  defp compare(left, right) when is_list(left) and is_integer(right) do
    compare(left, [right])
  end

  defp compare(left, right) when is_integer(left) and is_list(right) do
    compare([left], right)
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
