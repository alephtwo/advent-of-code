defmodule Day06 do
  @moduledoc """
  Day 6 of Advent of Code 2020.
  """

  @input File.read!("priv/06.txt")

  def part_one(input \\ @input) do
    input
    |> parse_input()
    |> Enum.map(&determine_group_yes_responses/1)
    |> Enum.map(&Enum.count/1)
    |> Enum.sum()
  end

  def part_two(input \\ @input) do
    input
    |> parse_input()
    |> Enum.map(&determine_everyone_yes_responses/1)
    |> Enum.map(&Enum.count/1)
    |> Enum.sum()
  end

  defp determine_group_yes_responses(responses) do
    responses
    |> Enum.map(&String.graphemes/1)
    |> Enum.map(&MapSet.new/1)
    |> Enum.reduce(&MapSet.union/2)
  end

  defp determine_everyone_yes_responses(responses) do
    responses
    |> Enum.map(&String.graphemes/1)
    |> Enum.map(&MapSet.new/1)
    |> Enum.reduce(&MapSet.intersection/2)
  end

  defp parse_input(input) do
    input
    |> String.split("\n\n", trim: true)
    |> Enum.map(&String.split(&1, "\n", trim: true))
  end
end
