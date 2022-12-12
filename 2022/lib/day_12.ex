defmodule Day12 do
  @moduledoc """
  Day 12 of Advent of Code 2022.
  """

  @doc """
  """
  @spec part_one(String.t()) :: number()
  def part_one(input) do
    grid = parse_input(input)
    %{"S" => start, "E" => goal} = identify_key_locations(grid)
    paths = pathfind(grid, start, goal, [])
    Enum.count(paths)
  end

  @doc """
  """
  @spec part_two(String.t()) :: number()
  def part_two(input) do
    grid = parse_input(input)
  end

  defp parse_input(input) do
    input
    |> String.split("\n", trim: true)
    |> Enum.with_index()
    |> Enum.flat_map(fn {line, y} ->
      line
      |> String.graphemes()
      |> Enum.with_index()
      |> Enum.map(fn {point, x} -> {{x, y}, point} end)
    end)
    |> Map.new()
  end

  @key_locations ["S", "E"]
  defp identify_key_locations(grid) do
    grid
    |> Map.to_list()
    |> Enum.filter(fn {_, c} -> Enum.member?(@key_locations, c) end)
    |> Enum.map(fn {point, c} -> {c, point} end)
    |> Map.new()
  end

  defp pathfind(_grid, current, goal, paths) when current == goal, do: Enum.reverse(paths)

  defp pathfind(grid, current, goal, paths) do
    next = determine_next_step(grid, current, goal)
    pathfind(grid, next, goal, [next | paths])
  end

  defp determine_next_step(grid, current = {cx, cy}, goal) do
    <<current_height::utf8>> = gauge_height(grid, current)

    viable_next_steps =
      grid
      |> Map.take([{cx, cy - 1}, {cx, cy + 1}, {cx - 1, cy}, {cx + 1, cy}])
      |> Enum.map(fn {point, value} -> {point, gauge_height(value)} end)
      |> Enum.filter(fn {_, <<height::utf8>>} -> abs(current_height - height) <= 1 end)

    # Pick a totally random next step
    # this is definitely not the right solution but it's a thing for now
    next =
      viable_next_steps
      |> Enum.random()
      |> then(fn {point, _} -> point end)

    next
  end

  defp gauge_height(grid, point), do: gauge_height(Map.get(grid, point))

  defp gauge_height(value) do
    case value do
      "S" -> "a"
      "E" -> "z"
      c -> c
    end
  end
end
