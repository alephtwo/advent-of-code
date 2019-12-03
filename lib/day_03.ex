defmodule Day03 do
  @moduledoc """
  Day 3 of Advent of Code 2019.
  """
  @input File.read!("priv/03.txt")
         |> String.split("\n", trim: true)
         |> Enum.map(fn x -> String.split(x, ",", trim: true) end)

  @central_point {0, 0}

  def part_one do
    min_manhattan_distance(@input)
  end

  @spec min_manhattan_distance(list) :: number
  def min_manhattan_distance(wires) when is_list(wires) do
    [%{paths: first}, %{paths: second}] = get_paths(wires)
    first
    |> MapSet.delete(@central_point)
    |> MapSet.intersection(second)
    |> Enum.map(fn {x, y} -> abs(x) + abs(y) end)
    |> Enum.min()
  end

  def part_two do
    min_junction_distance(@input)
  end

  @spec min_junction_distance(list) :: number
  def min_junction_distance(wires) when is_list(wires) do
    [first, second] = get_paths(wires)

    # Figure out where intersections are
    junctions = MapSet.intersection(first.paths, second.paths)

    junctions
    |> Enum.map(fn j -> Map.get(first.steps, j, 0) + Map.get(second.steps, j, 0) end)
    |> Enum.filter(fn x -> x != 0 end)
    |> Enum.min()
  end

  defp get_paths(wires) do
    accumulator = %{
      paths: MapSet.new() |> MapSet.put(@central_point),
      step: 0,
      steps: Map.new(),
      current: @central_point
    }

    wires
    |> Enum.map(fn wire -> Enum.reduce(wire, accumulator, &reduce_path/2) end)
  end

  defp reduce_path(instruction, %{paths: paths, step: step, steps: steps, current: {x, y}}) do
    length = instruction |> String.slice(1..-1) |> String.to_integer()
    directions =
      case String.first(instruction) do
        "U" -> ((y + 1)..(y + length)) |> Enum.map(fn l -> {x, l} end)
        "D" -> ((y - 1)..(y - length)) |> Enum.map(fn l -> {x, l} end)
        "R" -> ((x + 1)..(x + length)) |> Enum.map(fn l -> {l, y} end)
        "L" -> ((x - 1)..(x - length)) |> Enum.map(fn l -> {l, y} end)
      end

    these_steps = directions |> Enum.with_index(step + 1) |> Map.new()

    %{
      paths: MapSet.union(paths, MapSet.new(directions)),
      step: step + length,
      steps: Map.merge(these_steps, steps), # prefer existing entries
      current: Enum.at(directions, -1)
    }
  end
end
