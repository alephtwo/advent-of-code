defmodule Day14 do
  @moduledoc """
  Day 14 of Advent of Code 2022.
  """

  @doc """
  """
  @spec part_one(String.t()) :: number()
  def part_one(input) do
    lines = parse_input(input)
    {left, right} = find_left_right(lines)
    bottom = find_bottom(lines)
    empty_cave = build_empty_matrix(left, right, bottom)
    cave = Enum.reduce(lines, empty_cave, &draw_line/2)

    cave
    |> drop_sand()
    |> then(fn {:ok, c} -> c end)
    |> Map.values()
    |> Enum.filter(fn c -> c == :sand end)
    |> Enum.count()
  end

  @doc """
  """
  @spec part_two(String.t()) :: number()
  def part_two(input) do
    input
    |> parse_input()
    |> IO.inspect()
  end

  @drop_sand_at 500
  defp drop_sand(cave) do
    case simulate_drop(cave, {@drop_sand_at, 0}) do
      # if this drop goes off the map we just need to return the existing cave
      :rollback -> {:ok, cave}
      # otherwise just keep going
      {:continue, next} -> drop_sand(next)
    end
  end

  defp simulate_drop(cave, {x, y}) do
    down = {x, y + 1}
    down_left = {x - 1, y + 1}
    down_right = {x + 1, y + 1}

    cond do
      # look down
      !Map.has_key?(cave, down) ->
        :rollback

      Map.get(cave, down) == :air ->
        simulate_drop(cave, down)

      # look down left
      !Map.has_key?(cave, down_left) ->
        :rollback

      Map.get(cave, down_left) == :air ->
        simulate_drop(cave, down_left)

      # look down right
      !Map.has_key?(cave, down_right) ->
        :rollback

      Map.get(cave, down_right) == :air ->
        simulate_drop(cave, down_right)

      # come to a stop
      true ->
        {:continue, Map.put(cave, {x, y}, :sand)}
    end
  end

  defp parse_input(input) do
    input
    |> String.split("\n", trim: true)
    |> Enum.flat_map(&parse_line/1)
  end

  defp parse_line(line) do
    line
    |> String.split(" -> ", trim: true)
    |> Enum.map(&parse_coords/1)
    |> Enum.chunk_every(2, 1, :discard)
  end

  defp parse_coords(string) do
    string
    |> String.split(",")
    |> Enum.map(&String.to_integer/1)
    |> then(fn [x, y] -> {x, y} end)
  end

  defp find_left_right(lines) do
    lines
    |> Enum.flat_map(fn [{x1, _}, {x2, _}] -> [x1, x2] end)
    |> Enum.min_max()
  end

  defp find_bottom(lines) do
    lines
    |> Enum.flat_map(fn [{_, y1}, {_, y2}] -> [y1, y2] end)
    |> Enum.max()
  end

  defp build_empty_matrix(left, right, bottom) do
    0..bottom
    |> Enum.flat_map(fn y -> Enum.map(left..right, fn x -> {{x, y}, :air} end) end)
    |> Map.new()
  end

  # vertical lines
  defp draw_line([{x, y1}, {x, y2}], matrix) do
    Enum.reduce(y1..y2, matrix, fn y, m -> Map.put(m, {x, y}, :rock) end)
  end

  # horizontal lines
  defp draw_line([{x1, y}, {x2, y}], matrix) do
    Enum.reduce(x1..x2, matrix, fn x, m -> Map.put(m, {x, y}, :rock) end)
  end
end
