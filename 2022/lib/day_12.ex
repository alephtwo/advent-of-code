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

    pathfind(grid, start, goal, [])
    |> Enum.count()
  end

  @doc """
  """
  @spec part_two(String.t()) :: number()
  def part_two(input) do
    _grid = parse_input(input)
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

  # this pathfinding is massively inefficient for large data sets
  # parallelizing it is a hack and definitely a sign that something is very
  defp pathfind(_grid, current, goal, path) when current == goal, do: path

  defp pathfind(grid, current = {cx, cy}, goal, path) do
    <<current_height::utf8>> = gauge_height(grid, current)

    possible_next_steps =
      grid
      # four cardinal directions - will only return values that exist in the map
      |> Map.take([{cx + 1, cy}, {cx - 1, cy}, {cx, cy + 1}, {cx, cy - 1}])
      |> Enum.filter(fn {p, h} ->
        # don't go backwards
        seen = !Enum.member?(path, p)
        # can only go one up or down in height
        <<height::utf8>> = gauge_height(h)
        seen and abs(height - current_height) <= 1
      end)
      |> Enum.map(fn {p, _} -> p end)

    # Fan out to each of them and see how it goes...
    forks =
      possible_next_steps
      |> Enum.map(&pathfind(grid, &1, goal, [&1 | path]))
      |> Enum.filter(fn path -> path != :dead_end end)

    if Enum.empty?(forks) do
      # this is a bad end
      :dead_end
    else
      Enum.min_by(forks, fn path -> Enum.count(path) end)
    end
  end

  @key_locations ["S", "E"]
  defp identify_key_locations(grid) do
    grid
    |> Map.to_list()
    |> Enum.filter(fn {_, c} -> Enum.member?(@key_locations, c) end)
    |> Enum.map(fn {point, c} -> {c, point} end)
    |> Map.new()
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
