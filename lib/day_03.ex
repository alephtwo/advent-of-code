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
    [first, second] = get_paths(wires)
    first
    |> MapSet.delete(@central_point)
    |> MapSet.intersection(second)
    |> Enum.map(fn {x, y} -> abs(x) + abs(y) end)
    |> Enum.min()
  end

  defp get_paths(wires) do
    accumulator = %{
      paths: MapSet.new() |> MapSet.put(@central_point),
      current: @central_point
    }

    [%{paths: first}, %{paths: second}] = Enum.map(wires, fn wire ->
      Enum.reduce(wire, accumulator, &reduce_path/2)
    end)
    [first, second]
  end

  defp reduce_path(instruction, %{paths: paths, current: {x, y}}) do
    length = instruction |> String.slice(1..-1) |> String.to_integer()
    directions =
      case String.first(instruction) do
        "U" -> ((y + 1)..(y + length)) |> Enum.map(fn l -> {x, l} end)
        "D" -> ((y - 1)..(y - length)) |> Enum.map(fn l -> {x, l} end)
        "R" -> ((x + 1)..(x + length)) |> Enum.map(fn l -> {l, y} end)
        "L" -> ((x - 1)..(x - length)) |> Enum.map(fn l -> {l, y} end)
      end

    %{
      paths: MapSet.union(paths, MapSet.new(directions)),
      current: Enum.at(directions, -1)
    }
  end
end
