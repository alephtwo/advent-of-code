defmodule AdventOfCode2023.Day03 do
  @moduledoc """
  """

  defmodule Schematic do
    @moduledoc """
    Represents an engine schematic.
    """
    defstruct height: nil, width: nil, contents: nil
  end

  defmodule ContiguousNumber do
    defstruct value: nil, y: nil, x_min: nil, x_max: nil
  end

  @spec part_one(binary()) :: any()
  @doc """
  """
  def part_one(input) do
    lines = parse_lines(input)
    schematic = build_schematic(lines)
    numbers = scan_for_numbers(lines)

    numbers
    |> Enum.filter(&number_is_adjacent_to_symbol(schematic, &1))
    |> Enum.map(fn %ContiguousNumber{value: value} -> value end)
    |> Enum.sum()
  end

  @doc """
  """
  def part_two(input) do
    lines = parse_lines(input)
    schematic = build_schematic(lines)

    numbers = scan_for_numbers(lines)
    gears = locate_gears(schematic)

    gears
    |> Enum.map(fn {x, y} ->
      # find numbers that are adjacent to this point
      adjacent_numbers =
        Enum.filter(numbers, fn number ->
          x >= number.x_min - 1 &&
            x <= number.x_max + 1 &&
            y >= number.y - 1 &&
            y <= number.y + 1
        end)

      {{x, y}, adjacent_numbers}
    end)
    |> Enum.filter(fn {_, numbers} -> Enum.count(numbers) == 2 end)
    |> Enum.map(fn {_, [%ContiguousNumber{value: v1}, %ContiguousNumber{value: v2}]} ->
      v1 * v2
    end)
    |> Enum.sum()
  end

  defp parse_lines(input) do
    input
    |> String.split("\n", trim: true)
    |> Enum.with_index()
  end

  defp build_schematic(lines) do
    schematic =
      lines
      |> Enum.flat_map(fn {line, y} ->
        line
        |> String.graphemes()
        |> Enum.with_index()
        |> Enum.map(fn {char, x} ->
          {{x, y}, char}
        end)
      end)
      |> Map.new()

    max_x = schematic |> Enum.map(fn {{x, _}, _} -> x end) |> Enum.max()
    max_y = schematic |> Enum.map(fn {{_, y}, _} -> y end) |> Enum.max()

    %Schematic{
      height: max_y + 1,
      width: max_x + 1,
      contents: schematic
    }
  end

  defp scan_for_numbers(lines) do
    lines
    |> Enum.flat_map(fn {line, y} ->
      case Regex.scan(~r/\d+/, line, return: :index) do
        [] ->
          []

        numbers ->
          Enum.map(numbers, fn [{start, length}] ->
            %ContiguousNumber{
              value: line |> String.slice(start, length) |> Integer.parse() |> elem(0),
              y: y,
              x_min: start,
              x_max: start + length - 1
            }
          end)
      end
    end)
  end

  defp number_is_adjacent_to_symbol(schematic = %Schematic{}, number = %ContiguousNumber{}) do
    # check the bounding box of the number
    x_min = max(0, number.x_min - 1)
    x_max = min(schematic.width - 1, number.x_max + 1)
    y_min = max(0, number.y - 1)
    y_max = min(schematic.height - 1, number.y + 1)

    Enum.any?(y_min..y_max, fn y ->
      Enum.any?(x_min..x_max, fn x -> is_symbol(Map.get(schematic.contents, {x, y})) end)
    end)
  end

  defp is_symbol("."), do: false

  defp is_symbol(c) do
    case Integer.parse(c) do
      :error -> true
      _ -> false
    end
  end

  defp locate_gears(schematic = %Schematic{}) do
    schematic.contents
    |> Enum.filter(fn {_, value} -> value == "*" end)
    |> Enum.map(fn {point, _} -> point end)
  end
end
