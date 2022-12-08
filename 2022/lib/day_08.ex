defmodule Day08 do
  @moduledoc """
  Day 8 of Advent of Code 2022.
  """

  @doc """
  The expedition comes across a peculiar patch of tall trees all planted carefully in a grid. The Elves explain that a
  previous expedition planted these trees as a reforestation effort. Now, they're curious if this would be a good
  location for a tree house.

  First, determine whether there is enough tree cover here to keep a tree house hidden. To do this, you need to count
  the number of trees that are visible from outside the grid when looking directly along a row or column.

  The Elves have already launched a quadcopter to generate a map with the height of each tree (your puzzle input). For
  example:

  ```text
  30373
  25512
  65332
  33549
  35390
  ```

  Each tree is represented as a single digit whose value is its height, where 0 is the shortest and 9 is the tallest.

  A tree is visible if all of the other trees between it and an edge of the grid are shorter than it. Only consider
  trees in the same row or column; that is, only look up, down, left, or right from any given tree.

  All of the trees around the edge of the grid are visible - since they are already on the edge, there are no trees to
  block the view. In this example, that only leaves the interior nine trees to consider:

  * The top-left 5 is visible from the left and top. (It isn't visible from the right or bottom since other trees of
      height 5 are in the way.)
  * The top-middle 5 is visible from the top and right.
  * The top-right 1 is not visible from any direction; for it to be visible, there would need to only be trees of height
      0 between it and an edge.
  * The left-middle 5 is visible, but only from the right.
  * The center 3 is not visible from any direction; for it to be visible, there would need to be only trees of at most
      height 2 between it and an edge.
  * The right-middle 3 is visible from the right.
  * In the bottom row, the middle 5 is visible, but the 3 and 4 are not.

  With 16 trees visible on the edge and another 5 visible in the interior, a total of 21 trees are visible in this
  arrangement.

  Consider your map; how many trees are visible from outside the grid?
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
  Content with the amount of tree cover available, the Elves just need to know
  the best spot to build their tree house: they would like to be able to see a
  lot of trees.

  To measure the viewing distance from a given tree, look up, down, left, and
  right from that tree; stop if you reach an edge or at the first tree that is
  the same height or taller than the tree under consideration. (If a tree is
  right on the edge, at least one of its viewing distances will be zero.)

  The Elves don't care about distant trees taller than those found by the rules
  above; the proposed tree house has large eaves to keep it dry, so they
  wouldn't be able to see higher than the tree house anyway.

  In the example above, consider the middle 5 in the second row:

  ```text
  30373
  25512
  65332
  33549
  35390
  ```

  * Looking up, its view is not blocked; it can see 1 tree (of height 3).
  * Looking left, its view is blocked immediately; it can see only 1 tree (of
      height 5, right next to it).
  * Looking right, its view is not blocked; it can see 2 trees.
  * Looking down, its view is blocked eventually; it can see 2 trees (one of
      height 3, then the tree of height 5 that blocks its view).

  A tree's scenic score is found by multiplying together its viewing distance in
      each of the four directions. For this tree, this is 4 (found by
      multiplying 1 * 1 * 2 * 2).

  However, you can do even better: consider the tree of height 5 in the middle
  of the fourth row:

  ```text
  30373
  25512
  65332
  33549
  35390
  ```

  * Looking up, its view is blocked at 2 trees (by another tree with a height of
      5).
  * Looking left, its view is not blocked; it can see 2 trees.
  * Looking down, its view is also not blocked; it can see 1 tree.
  * Looking right, its view is blocked at 2 trees (by a massive tree of height
      9).

  This tree's scenic score is 8 (2 * 2 * 1 * 2); this is the ideal spot for the
  tree house.

  Consider each tree on your map. What is the highest scenic score possible for
  any tree?
  """
  @spec part_two(String.t()) :: number()
  def part_two(input) do
    matrix = parse_input(input)
    height = Enum.count(matrix)
    width = matrix |> Enum.at(0) |> Enum.count()
    points = for y <- 0..(height - 1), x <- 0..(width - 1), do: {x, y}

    points
    |> Enum.filter(fn {x, y} -> x > 0 and y > 0 and x < width - 1 and y < height - 1 end)
    |> Enum.map(fn p -> calculate_scenic_score({matrix, width, height}, p) end)
    |> Enum.max()
  end

  defp parse_input(input) do
    input
    |> String.split("\n", trim: true)
    |> Enum.map(fn s -> s |> String.graphemes() |> Enum.map(&String.to_integer/1) end)
  end

  defp is_visible({x, y}, acc = %{matrix: matrix, height: height, width: width, sum: sum}) do
    cond do
      # left or right side, automatically visible
      x == 0 or x == height - 1 ->
        %{acc | sum: sum + 1}

      # top or bottom, automatically visible
      y == 0 or y == height - 1 ->
        %{acc | sum: sum + 1}

      inner_tree_is_visible({matrix, width, height}, {x, y}) ->
        %{acc | sum: sum + 1}

      true ->
        acc
    end
  end

  defp inner_tree_is_visible({matrix, width, height}, {x, y})
       when x > 0 and x < width and y > 0 and y < height do
    tree_height = get_point(matrix, {x, y})

    # look left
    vl = Enum.all?(0..(x - 1), fn i -> get_point(matrix, {i, y}) < tree_height end)
    # look right
    vr =
      Enum.all?(min(x + 1, width - 1)..(width - 1), fn i ->
        get_point(matrix, {i, y}) < tree_height
      end)

    # look up
    vu = Enum.all?(0..(y - 1), fn j -> get_point(matrix, {x, j}) < tree_height end)
    # look down
    vd =
      Enum.all?(min(y + 1, height - 1)..(height - 1), fn j ->
        get_point(matrix, {x, j}) < tree_height
      end)

    vl or vr or vu or vd
  end

  defp calculate_scenic_score({matrix, width, height}, {x, y}) do
    tree_height = get_point(matrix, {x, y})
    w = width - 1
    h = height - 1

    su = look_in_direction((y - 1)..0, tree_height, fn j -> get_point(matrix, {x, j}) end)
    sl = look_in_direction((x - 1)..0, tree_height, fn i -> get_point(matrix, {i, y}) end)
    sr = look_in_direction(min(x + 1, w)..w, tree_height, fn i -> get_point(matrix, {i, y}) end)
    sd = look_in_direction(min(y + 1, h)..h, tree_height, fn j -> get_point(matrix, {x, j}) end)

    sl * sr * su * sd
  end

  defp look_in_direction(range, tree_height, get_point) do
    range
    |> Stream.map(fn i -> get_point.(i) end)
    |> Enum.reduce_while(0, fn x, trees ->
      if x >= tree_height, do: {:halt, trees + 1}, else: {:cont, trees + 1}
    end)
  end

  defp get_point(matrix, {x, y}) do
    matrix
    |> Enum.at(y)
    |> Enum.at(x)
  end
end
