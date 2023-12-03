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
    _schematic = build_schematic(lines)
    _numbers = scan_for_numbers(lines)
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
              x_max: start + length
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
end
