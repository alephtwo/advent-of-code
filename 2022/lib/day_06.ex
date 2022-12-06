defmodule Day06 do
  @moduledoc """
  Day 6 of Advent of Code 2022.
  """

  @doc """
  """
  @spec part_one(String.t()) :: number()
  def part_one(input) do
    input
    |> parse_input()
    |> scrub_input(4)
  end

  @doc """
  """
  @spec part_two(String.t()) :: number()
  def part_two(input) do
    input
    |> parse_input()
    |> scrub_input(14)
  end

  defp parse_input(input), do: String.split(input, "", trim: true)

  defp scrub_input(list, block_size, index \\ 0) do
    block = Enum.take(list, block_size)

    if block |> Enum.uniq() |> Enum.count() == block_size do
      # we've found four uniques but the index is block_size behind
      index + block_size
    else
      [_ | rest] = list
      scrub_input(rest, block_size, index + 1)
    end
  end
end
