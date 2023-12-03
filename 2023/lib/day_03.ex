defmodule AdventOfCode2023.Day03 do
  @moduledoc """
  Day 3: Gear Ratios
  """

  defmodule Schematic do
    @moduledoc """
    Represents an engine schematic.
    """
    defstruct height: nil, width: nil, contents: nil
  end

  defmodule ContiguousNumber do
    @moduledoc """
    Represents the concept of a number on a line with its bounding box.
    """
    defstruct value: nil, y: nil, x_min: nil, x_max: nil
  end

  @doc """
  You and the Elf eventually reach a gondola lift station; he says the gondola
  lift will take you up to the water source, but this is as far as he can bring
  you. You go inside.

  It doesn't take long to find the gondolas, but there seems to be a problem:
  they're not moving.

  "Aaah!"

  You turn around to see a slightly-greasy Elf with a wrench and a look of
  surprise. "Sorry, I wasn't expecting anyone! The gondola lift isn't working
  right now; it'll still be a while before I can fix it." You offer to help.

  The engineer explains that an engine part seems to be missing from the engine,
  but nobody can figure out which one. If you can add up all the part numbers in
  the engine schematic, it should be easy to work out which part is missing.

  The engine schematic (your puzzle input) consists of a visual representation
  of the engine. There are lots of numbers and symbols you don't really
  understand, but apparently any number adjacent to a symbol, even diagonally,
  is a "part number" and should be included in your sum. (Periods (`.`) do not
  count as a symbol.)

  Here is an example engine schematic:

  ```
  467..114..
  ...*......
  ..35..633.
  ......#...
  617*......
  .....+.58.
  ..592.....
  ......755.
  ...$.*....
  .664.598..
  ```

  In this schematic, two numbers are not part numbers because they are not
  adjacent to a symbol: `114` (top right) and `58` (middle right). Every other
  number is adjacent to a symbol and so is a part number; their sum is `4361`.

  Of course, the actual engine schematic is much larger. What is the sum of all
  of the part numbers in the engine schematic?
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
  The engineer finds the missing part and installs it in the engine! As the
  engine springs to life, you jump in the closest gondola, finally ready to
  ascend to the water source.

  You don't seem to be going very fast, though. Maybe something is still wrong?
  Fortunately, the gondola has a phone labeled "help", so you pick it up and the
  engineer answers.

  Before you can explain the situation, she suggests that you look out the
  window. There stands the engineer, holding a phone in one hand and waving with
  the other. You're going so slowly that you haven't even left the station. You
  exit the gondola.

  The missing part wasn't the only issue - one of the gears in the engine is
  wrong. A gear is any * symbol that is adjacent to exactly two part numbers.
  Its gear ratio is the result of multiplying those two numbers together.

  This time, you need to find the gear ratio of every gear and add them all up
  so that the engineer can figure out which gear needs to be replaced.

  Consider the same engine schematic again:

  ```
  467..114..
  ...*......
  ..35..633.
  ......#...
  617*......
  .....+.58.
  ..592.....
  ......755.
  ...$.*....
  .664.598..
  ```

  In this schematic, there are two gears. The first is in the top left; it has
  part numbers `467` and `35`, so its gear ratio is `16345`. The second gear is
  in the lower right; its gear ratio is `451490`. (The `*` adjacent to `617` is
  not a gear because it is only adjacent to one part number.) Adding up all of
  the gear ratios produces `467835`.

  What is the sum of all of the gear ratios in your engine schematic?
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
          # credo:disable-for-next-line
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
