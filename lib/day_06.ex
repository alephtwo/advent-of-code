defmodule Day06 do
  @moduledoc """
  Day 6 of Advent of Code 2020.
  """

  @input File.read!("priv/06.txt")

  def part_one(input \\ @input), do: sum_responses_using_function(input, &MapSet.union/2)

  def part_two(input \\ @input), do: sum_responses_using_function(input, &MapSet.intersection/2)

  defp sum_responses_using_function(input, function) do
    input
    |> parse_input()
    |> Enum.map(&determine_responses_using_function(&1, function))
    |> Enum.map(&Enum.count/1)
    |> Enum.sum()
  end

  defp determine_responses_using_function(responses, function) do
    responses
    |> Enum.map(&String.graphemes/1)
    |> Enum.map(&MapSet.new/1)
    |> Enum.reduce(function)
  end

  defp parse_input(input) do
    input
    |> String.split("\n\n", trim: true)
    |> Enum.map(&String.split(&1, "\n", trim: true))
  end
end
