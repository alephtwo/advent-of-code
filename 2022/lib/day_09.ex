defmodule Day09 do
  @moduledoc """
  Day 9 of Advent of Code 2022.
  """

  defmodule State do
    defstruct tail_locations: [], head: {0, 0}, tail: {0, 0}
  end

  @doc """
  """
  @spec part_one(String.t()) :: number()
  def part_one(input) do
    input
    |> parse_input()
    |> Enum.reduce(%State{}, &drag_rope/2)
  end

  @doc """
  """
  @spec part_two(String.t()) :: number()
  def part_two(input) do
    input
    |> parse_input()
    |> IO.inspect()
  end

  defp drag_rope({direction, amplitude}, state) do
    direction
    |> List.duplicate(amplitude)
    |> Enum.reduce(state, &drag_rope/2)
  end

  defp drag_rope(
         direction,
         state = %State{
           tail_locations: [],
           head: {head_x, head_y},
           tail: {tail_x, tail_y}
         }
       ) do
    head =
      case direction do
        "R" -> {head_x + 1, head_y}
        "L" -> {head_x - 1, head_y}
        "U" -> {head_x, head_y + 1}
        "D" -> {head_x, head_y - 1}
      end

    %State{state | head: head}
  end

  def grid_distance({head_x, head_y}, {tail_x, tail_y}),
    do: {abs(head_x - tail_x), abs(head_y - tail_y)}

  def is_adjacent(head, tail) do
    {x, y} = grid_distance(head, tail)
    x <= 1 and y <= 1
  end

  defp parse_input(input) do
    input
    |> String.split("\n", trim: true)
    |> Enum.map(fn s ->
      [direction, amplitude] = String.split(s)
      {direction, String.to_integer(amplitude)}
    end)
  end
end
