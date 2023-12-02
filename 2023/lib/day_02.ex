defmodule AdventOfCode2023.Day02 do
  @moduledoc """
  """

  @doc """
  """
  def part_one(input) do
    input
    |> parse_input()
    |> Enum.filter(
      &check_game(&1, %{
        "red" => 12,
        "green" => 13,
        "blue" => 14
      })
    )
    |> Enum.map(fn game -> game.id end)
    |> Enum.sum()
  end

  @doc """
  """
  def part_two(input) do
    input
    |> parse_input()
    |> Enum.map(&get_min_cubes/1)
    |> Enum.map(fn limits -> limits |> Map.values() |> Enum.product() end)
    |> Enum.sum()
  end

  defp parse_input(input) do
    input
    |> String.split("\n", trim: true)
    |> Enum.map(fn line ->
      [_, id, contents] = Regex.run(~r/Game (\d+)\: (.*)/, line)

      pulls =
        contents
        |> String.split(";", trim: true)
        |> Enum.map(&parse_pull/1)

      %{
        id: id |> Integer.parse() |> elem(0),
        pulls: pulls
      }
    end)
  end

  defp parse_pull(pull) do
    pull
    |> String.split(",", trim: true)
    |> Enum.map(fn handful ->
      [_, count, color] = Regex.run(~r/(\d+) (.*)/, handful)
      {color, count |> Integer.parse() |> elem(0)}
    end)
    |> Map.new()
  end

  defp check_game(game, known_contents) do
    # Check all pulls in the game against known contents
    # If the game is good, "not any" aka "none of these but return fast"
    !Enum.any?(game.pulls, fn pull ->
      # in the pull, none of the colors will have exceeded the known contents
      Enum.any?(pull, fn {color, amount} -> amount > Map.get(known_contents, color) end)
    end)
  end

  defp get_min_cubes(game) do
    Enum.reduce(game.pulls, %{"red" => 0, "green" => 0, "blue" => 0}, fn pull, acc ->
      %{
        "red" => max(Map.get(acc, "red"), Map.get(pull, "red", -1)),
        "green" => max(Map.get(acc, "green"), Map.get(pull, "green", -1)),
        "blue" => max(Map.get(acc, "blue"), Map.get(pull, "blue", -1))
      }
    end)
  end
end
