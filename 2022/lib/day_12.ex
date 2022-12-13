defmodule Day12 do
  @moduledoc """
  Day 12 of Advent of Code 2022.
  """

  @doc """
  You try contacting the Elves using your handheld device, but the river you're
  following must be too low to get a decent signal.

  You ask the device for a heightmap of the surrounding area (your puzzle
  input). The heightmap shows the local area from above broken into a grid; the
  elevation of each square of the grid is given by a single lowercase letter,
  where a is the lowest elevation, b is the next-lowest, and so on up to the
  highest elevation, z.

  Also included on the heightmap are marks for your current position (S) and the
  location that should get the best signal (E). Your current position (S) has
  elevation a, and the location that should get the best signal (E) has
  elevation z.

  You'd like to reach E, but to save energy, you should do it in as few steps as
  possible. During each step, you can move exactly one square up, down, left, or
  right. To avoid needing to get out your climbing gear, the elevation of the
  destination square can be at most one higher than the elevation of your
  current square; that is, if your current elevation is m, you could step to
  elevation n, but not to elevation o. (This also means that the elevation of
  the destination square can be much lower than the elevation of your current
  square.)

  For example:

  ```text
  Sabqponm
  abcryxxl
  accszExk
  acctuvwj
  abdefghi
  ```

  Here, you start in the top-left corner; your goal is near the middle. You
  could start by moving down or right, but eventually you'll need to head toward
  the e at the bottom. From there, you can spiral around to the goal:

  ```text
  v..v<<<<
  >v.vv<<^
  .>vv>E^^
  ..v>>>^^
  ..>>>>>^
  ```

  In the above diagram, the symbols indicate whether the path exits each square
  moving up (^), down (v), left (<), or right (>). The location that should get
  the best signal is still E, and . marks unvisited squares.

  This path reaches the goal in 31 steps, the fewest possible.

  What is the fewest steps required to move from your current position to the
  location that should get the best signal?
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
  As you walk up the hill, you suspect that the Elves will want to turn this
  into a hiking trail. The beginning isn't very scenic, though; perhaps you can
  find a better starting point.

  To maximize exercise while hiking, the trail should start as low as possible:
  elevation a. The goal is still the square marked E. However, the trail should
  still be direct, taking the fewest steps to reach its goal. So, you'll need to
  find the shortest path from any square at elevation a to the square marked E.

  Again consider the example from above:

  ```text
  Sabqponm
  abcryxxl
  accszExk
  acctuvwj
  abdefghi
  ```

  Now, there are six choices for starting position (five marked a, plus the
  square marked S that counts as being at elevation a). If you start at the
  bottom-left square, you can reach the goal most quickly:

  ```text
  ...v<<<<
  ...vv<<^
  ...v>E^^
  .>v>>>^^
  >^>>>>>^
  ```

  This path reaches the goal in only 29 steps, the fewest possible.

  What is the fewest steps required to move starting from any square with
  elevation a to the location that should get the best signal?
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
