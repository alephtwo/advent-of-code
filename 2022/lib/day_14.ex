defmodule Day14 do
  @moduledoc """
  Day 14 of Advent of Code 2022.
  """
  @source {500, 0}

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
  @padding 150
  @spec part_two(String.t()) :: number()
  def part_two(input) do
    lines = parse_input(input)

    {left, right} =
      lines
      |> find_left_right()
      # uhh just add some padding on either side, scuffed but it works
      |> then(fn {l, r} -> {l - @padding, r + @padding} end)

    bottom = find_bottom(lines)

    horizontal = fn y, type ->
      left..right
      |> Enum.map(fn x -> {{x, y}, type} end)
      |> Map.new()
    end

    empty_cave =
      build_empty_matrix(left, right, bottom)
      # draw a horizontal line of air at bottom + 1
      |> Map.merge(horizontal.(bottom + 1, :air))
      # draw a horizontal line of rock at bottom + 2
      |> Map.merge(horizontal.(bottom + 2, :rock))

    cave = Enum.reduce(lines, empty_cave, &draw_line/2)

    cave
    |> drop_sand_with_bottom()
    |> Map.values()
    |> Enum.filter(fn x -> x == :sand end)
    |> Enum.count()
  end

  defp drop_sand(cave) do
    case simulate_drop(cave, @source) do
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

  defp drop_sand_with_bottom(cave) do
    if Map.get(cave, @source) == :sand do
      cave
    else
      cave
      |> simulate_drop_with_bottom(@source)
      |> drop_sand_with_bottom()
    end
  end

  defp simulate_drop_with_bottom(cave, {x, y}) do
    down = {x, y + 1}
    down_left = {x - 1, y + 1}
    down_right = {x + 1, y + 1}

    cond do
      Map.get(cave, down) == :air ->
        simulate_drop_with_bottom(cave, down)

      Map.get(cave, down_left) == :air ->
        simulate_drop_with_bottom(cave, down_left)

      Map.get(cave, down_right) == :air ->
        simulate_drop_with_bottom(cave, down_right)

      true ->
        Map.put(cave, {x, y}, :sand)
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

  defp print_cave(cave) do
    coords = Map.keys(cave)

    {min_x, max_x} =
      coords
      |> Enum.map(fn {x, _} -> x end)
      |> Enum.min_max()

    {min_y, max_y} =
      coords
      |> Enum.map(fn {_, y} -> y end)
      |> Enum.min_max()

    Enum.each(min_y..max_y, fn y ->
      Enum.each(min_x..max_x, fn x ->
        char =
          case Map.get(cave, {x, y}) do
            :air -> "."
            :rock -> "#"
            :sand -> "o"
          end

        IO.write(char)
      end)

      IO.puts("")
    end)

    cave
  end
end
