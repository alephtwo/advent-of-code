defmodule Day09 do
  @moduledoc """
  Day 9 of Advent of Code 2022.
  """

  defmodule State do
    defstruct [:current_coords, :visited_coords]
  end

  @doc """
  """
  @spec part_one(String.t()) :: number()
  def part_one(input) do
    initial_coords = %{1 => {0, 0}, 2 => {0, 0}}

    visited_coords =
      initial_coords
      |> Enum.map(fn {k, v} -> {k, [v]} end)
      |> Map.new()

    input
    |> parse_input()
    |> Enum.reduce(
      %State{current_coords: initial_coords, visited_coords: visited_coords},
      &drag_rope/2
    )
    |> then(fn %State{visited_coords: t} -> Enum.at(t, -1) end)
    |> then(fn {_k, v} -> v end)
    |> Enum.uniq()
    |> Enum.count()
  end

  @doc """
  """
  @spec part_two(String.t()) :: number()
  def part_two(input) do
    initial_coords =
      1..10
      |> Enum.map(fn i -> {i, {0, 0}} end)
      |> Map.new()

    visited_coords =
      initial_coords
      |> Enum.map(fn {k, v} -> {k, [v]} end)
      |> Map.new()

    input
    |> parse_input()
    |> Enum.reduce(
      %State{current_coords: initial_coords, visited_coords: visited_coords},
      &drag_rope/2
    )
    |> then(fn %State{visited_coords: t} -> Enum.at(t, -1) end)
    |> then(fn {_k, v} -> v end)
    |> Enum.uniq()
    |> Enum.count()
  end

  defp drag_rope({direction, amplitude}, state) do
    direction
    |> List.duplicate(amplitude)
    |> Enum.reduce(state, &drag_rope/2)
  end

  defp drag_rope(direction, state = %State{current_coords: current_coords}) do
    {head_x, head_y} = Map.get(current_coords, 1)

    new_head =
      case direction do
        "R" -> {head_x + 1, head_y}
        "L" -> {head_x - 1, head_y}
        "U" -> {head_x, head_y + 1}
        "D" -> {head_x, head_y - 1}
      end

    new_positions =
      2..Enum.count(current_coords)
      |> Enum.reduce(%{1 => new_head}, fn i, acc ->
        relative_head = Map.get(acc, i - 1)
        relative_tail = Map.get(current_coords, i)
        new_tail = catch_up(relative_tail, relative_head)
        Map.put(acc, i, new_tail)
      end)
      |> Map.put(1, new_head)

    new_visited_coords =
      state.visited_coords
      |> Map.update!(1, fn l -> [new_head | l] end)
      |> Map.merge(new_positions, fn _k, v1, v2 -> [v2 | v1] end)

    %State{state | current_coords: new_positions, visited_coords: new_visited_coords}
  end

  defp catch_up(tail = {tail_x, tail_y}, head) do
    case grid_distance(head, tail) do
      {0, 0} ->
        tail

      {dx, dy} when abs(dx) == 1 and abs(dy) == 1 ->
        tail

      {0, 2} ->
        {tail_x, tail_y + 1}

      {0, -2} ->
        {tail_x, tail_y - 1}

      {2, 0} ->
        {tail_x + 1, tail_y}

      {-2, 0} ->
        {tail_x - 1, tail_y}

      {dx, dy} when dx > 0 and dy > 0 ->
        {tail_x + 1, tail_y + 1}

      {dx, dy} when dx > 0 and dy < 0 ->
        {tail_x + 1, tail_y - 1}

      {dx, dy} when dx < 0 and dy > 0 ->
        {tail_x - 1, tail_y + 1}

      {dx, dy} when dx < 0 and dy < 0 ->
        {tail_x - 1, tail_y - 1}

      {dx, dy} when dx == 0 and abs(dy) == 1 ->
        tail

      {dx, dy} when abs(dx) == 1 and dy == 0 ->
        tail
    end
  end

  def grid_distance({head_x, head_y}, {tail_x, tail_y}),
    do: {head_x - tail_x, head_y - tail_y}

  defp parse_input(input) do
    input
    |> String.split("\n", trim: true)
    |> Enum.map(fn s ->
      [direction, amplitude] = String.split(s)
      {direction, String.to_integer(amplitude)}
    end)
  end
end
