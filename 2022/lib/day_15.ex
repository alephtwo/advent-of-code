defmodule Day15 do
  @moduledoc """
  Day 15 of Advent of Code 2022.
  """

  defmodule Sensor do
    defstruct [:closest_beacon]
  end

  defmodule Beacon do
    defstruct []
  end

  defmodule Coverage do
    defstruct []
  end

  @doc """
  """
  @spec part_one(String.t(), integer()) :: number()
  def part_one(input, y0) do
    objects = parse_input(input)
    grid = Enum.reduce(objects, objects, &add_coverage/2)

    # find the boundaries of our box
    {min_x, max_x} =
      grid
      |> Enum.map(fn {{x, _}, _} -> x end)
      |> Enum.min_max()

    grid
    |> Enum.filter(fn {{_, y}, v} ->
      if y == y0 do
        case v do
          %Coverage{} -> true
          _ -> false
        end
      else
        false
      end
    end)
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

  @line_regex ~r/Sensor at x=(-?\d+), y=(-?\d+): closest beacon is at x=(-?\d+), y=(-?\d+)/
  defp parse_input(input) do
    input
    |> String.split("\n", trim: true)
    |> Enum.map(fn line ->
      [_, sx, sy, cbx, cby] = Regex.run(@line_regex, line)

      {
        {String.to_integer(sx), String.to_integer(sy)},
        {String.to_integer(cbx), String.to_integer(cby)}
      }
    end)
    |> place_objects()
  end

  defp place_objects(lines) do
    Enum.reduce(lines, %{}, fn {{sx, sy}, {cbx, cby}}, coords ->
      coords
      |> Map.put({sx, sy}, %Sensor{closest_beacon: {cbx, cby}})
      |> Map.put({cbx, cby}, %Beacon{})
    end)
  end

  defp add_coverage({_, %Beacon{}}, grid), do: grid

  defp add_coverage({center = {x, y}, %Sensor{closest_beacon: closest}}, grid) do
    # Find the distance to the nearest point
    {dx, dy} = manhattan_distance(center, closest)
    # this is the highest and widest we need to go in both directions
    amplitude = dx + dy

    # Simplistic: draw a box and filter to just the ones with appropriate manhattan distance
    # there are better ways to do this but I am supremely lazy
    box =
      draw_box(
        (x - amplitude)..(x + amplitude),
        (y - amplitude)..(y + amplitude)
      )

    coverage =
      box
      |> Enum.filter(fn p ->
        {xx, yy} = manhattan_distance(center, p)
        xx + yy <= amplitude
      end)

    Enum.reduce(coverage, grid, fn p, g -> Map.put_new(g, p, %Coverage{}) end)
  end

  defp manhattan_distance({x1, y1}, {x2, y2}), do: {abs(x2 - x1), abs(y2 - y1)}

  defp draw_box(x_range, y_range) do
    Enum.flat_map(x_range, fn x -> y_range |> Enum.map(fn y -> {x, y} end) end)
  end
end
