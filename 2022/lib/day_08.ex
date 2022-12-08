defmodule Day08 do
  @moduledoc """
  Day 8 of Advent of Code 2022.
  """

  @doc """
  """
  @spec part_one(String.t()) :: number()
  def part_one(input) do
    matrix = parse_input(input)

    height = Enum.count(matrix)
    width = matrix |> Enum.at(0) |> Enum.count()
    points = for y <- 0..(height - 1), x <- 0..(width - 1), do: {x, y}

    # Go through each point, check all directions
    points
    |> Enum.reduce(%{matrix: matrix, height: height, width: width, sum: 0}, &is_visible/2)
    |> Map.get(:sum)
  end

  @doc """
  """
  @spec part_two(String.t()) :: number()
  def part_two(input) do
    input
    |> parse_input()
    |> IO.inspect()
  end

  defp parse_input(input) do
    input
    |> String.split("\n", trim: true)
    |> Enum.map(fn s -> s |> String.graphemes() |> Enum.map(&String.to_integer/1) end)
  end

  defp is_visible({x, y}, acc = %{matrix: matrix, height: height, width: width, sum: sum}) do
    cond do
      # left or right side, automatically visible
      x == 0 or x == (height - 1) ->
        %{acc | sum: sum + 1}

      # top or bottom, automatically visible
      y == 0 or y == (height - 1) ->
        %{acc | sum: sum + 1}

      inner_tree_is_visible({matrix, width, height}, {x, y}) ->
        %{acc | sum: sum + 1}

      true ->
        acc
    end
  end

  defp inner_tree_is_visible({matrix, width, height}, {x, y}) when x > 0 and x < width and y > 0 and y < height do
    tree_height = get_point(matrix, {x, y})

    # look left
    vl = Enum.all?(0..(x - 1), fn i -> get_point(matrix, {i, y}) < tree_height end)
    # look right
    vr = Enum.all?(min(x + 1, width - 1)..(width - 1), fn i -> get_point(matrix, {i, y}) < tree_height end)
    # look up
    vu = Enum.all?(0..(y - 1), fn j -> get_point(matrix, {x, j}) < tree_height end)
    # look down
    vd = Enum.all?(min(y + 1, height - 1)..(height - 1), fn j ->
      get_point(matrix, {x, j}) < tree_height
    end)
    vl or vr or vu or vd
  end

  defp get_point(matrix, {x, y}) do
    matrix
    |> Enum.at(y)
    |> Enum.at(x)
  end
end
