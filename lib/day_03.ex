defmodule Day03 do
  @moduledoc """
  Day 3 of Advent of Code 2020.
  """
  @input File.read!("priv/03.txt")

  def part_one do
    trees_on_path(%{map: parse_map(@input), dx: 3, dy: 1})
  end

  def part_two do
    all_slopes_tree_product(parse_map(@input))
  end

  def trees_on_path(params) do
    Enum.count(sled_path(params), fn x -> x == "#" end)
  end

  def all_slopes_tree_product(map) do
    trees = [
      trees_on_path(%{map: map, dx: 1, dy: 1}),
      trees_on_path(%{map: map, dx: 3, dy: 1}),
      trees_on_path(%{map: map, dx: 5, dy: 1}),
      trees_on_path(%{map: map, dx: 7, dy: 1}),
      trees_on_path(%{map: map, dx: 1, dy: 2})
    ]

    Enum.reduce(trees, &*/2)
  end

  def sled_path(%{map: map, dx: dx, dy: dy}) do
    # Filter out the _rows_ we will visit based on our slope
    rows_visited = Enum.take_every(map, dy)

    # Based on how many rows we're going to visit, we need a certain width of columns.
    x_max = Enum.count(rows_visited) * dx

    # From those rows, filter out just the columns we'll visit
    rows_visited
    # Repeat every row infinitely for now.
    |> Enum.map(&Stream.cycle/1)
    # Filter this to the furthest right we're going to go.
    |> Enum.map(&Stream.take(&1, x_max))
    # Now take every dx columns.
    |> Enum.map(&Enum.take_every(&1, dx))
    # The "identity" diagonal of this matrix is the path visited.
    |> Enum.with_index()
    |> Enum.map(fn {y, i} -> Enum.at(y, i) end)
  end

  def parse_map(text) do
    text
    |> String.split("\n", trim: true)
    |> Enum.map(&String.graphemes/1)
  end
end
