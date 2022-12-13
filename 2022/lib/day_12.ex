defmodule Day12 do
  @moduledoc """
  Day 12 of Advent of Code 2022.
  """

  @doc """
  """
  @spec part_one(String.t()) :: number()
  def part_one(input) do
    grid = parse_input(input)
    graph = build_graph(grid)
    %{"S" => start, "E" => goal} = identify_key_locations(grid)

    graph
    |> Graph.dijkstra(start, goal)
    # ignore the start
    |> List.delete_at(0)
    |> Enum.count()
  end

  @doc """
  """
  @spec part_two(String.t()) :: number()
  def part_two(input) do
    grid = parse_input(input)

    entrances =
      grid
      |> Enum.filter(fn {_, v} -> v == "S" or v == "a" end)
      |> Enum.map(fn {p, _} -> p end)

    %{"S" => _, "E" => goal} = identify_key_locations(grid)

    graph = build_graph(grid)

    entrances
    |> Enum.map(fn p -> graph |> Graph.dijkstra(p, goal) end)
    # ignore dead ends
    |> Enum.filter(fn p -> p != nil end)
    # ignore the starting point
    |> Enum.map(fn p -> Enum.count(p) - 1 end)
    |> Enum.min()
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

  defp build_graph(grid) do
    points = Enum.map(grid, fn {p, _} -> p end)

    result =
      Graph.new()
      |> Graph.add_vertices(points)

    Enum.reduce(grid, result, fn {{x, y}, height}, graph ->
      viable_next_steps =
        grid
        # look in all directions - won't include points off the grid
        |> Map.take([{x + 1, y}, {x - 1, y}, {x, y + 1}, {x, y - 1}])
        # only select points we can actually travel to by height rules
        |> Enum.filter(fn {_, h} -> is_viable(normalize_height(height), normalize_height(h)) end)
        |> Enum.map(fn {p, _} -> {{x, y}, p} end)

      Graph.add_edges(graph, viable_next_steps)
    end)
  end

  defp normalize_height(value) do
    case value do
      "S" -> "a"
      "E" -> "z"
      c -> c
    end
  end

  defp is_viable(<<start::utf8>>, <<finish::utf8>>), do: finish - start <= 1
end
