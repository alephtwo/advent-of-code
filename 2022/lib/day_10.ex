defmodule Day10 do
  @moduledoc """
  Day 10 of Advent of Code 2022.
  """

  @doc """
  """
  @spec part_one(String.t()) :: number()
  def part_one(input) do
    signals =
      input
      |> parse_input()
      # offset by nil to handle one-based indexing
      |> Enum.reduce([nil, 1], &process_instruction/2)

    Enum.sum([
      signal_strength(signals, 20),
      signal_strength(signals, 60),
      signal_strength(signals, 100),
      signal_strength(signals, 140),
      signal_strength(signals, 180),
      signal_strength(signals, 220)
    ])
  end

  @doc """
  """
  @spec part_two(String.t()) :: String.t()
  def part_two(input) do
    signals =
      input
      |> parse_input()
      |> Enum.reduce([1], &process_instruction/2)

    # initialize as dark
    crt =
      "."
      # width = 40 pixels
      |> List.duplicate(40)
      # height = 6 pixels
      |> List.duplicate(6)

    output =
      signals
      |> Enum.with_index()
      |> Enum.reduce(crt, fn {signal, pixel}, out ->
        sprite_pixels = Enum.to_list((signal - 1)..(signal + 1))
        active_pixel = rem(pixel, 40)

        if Enum.member?(sprite_pixels, active_pixel) do
          # find the row
          row = div(pixel, 40)
          List.update_at(out, row, &List.update_at(&1, active_pixel, fn _ -> "#" end))
        else
          out
        end
      end)

    "#{print_crt(output)}\n"
  end

  defp process_instruction({:addx, value}, data_set) do
    # get the last state we've seen
    reversed_data = [x | _] = Enum.reverse(data_set)
    # add in the reversed value plus an extra to represent the extra clock tick
    Enum.reverse([x + value | [x | reversed_data]])
  end

  defp process_instruction(:noop, data_set) do
    # get the last state we've seen
    reversed_data = [x | _] = Enum.reverse(data_set)
    # insert it at the end
    Enum.reverse([x | reversed_data])
  end

  defp signal_strength(signals, i) do
    i * Enum.at(signals, i)
  end

  defp parse_input(input) do
    input
    |> String.split("\n", trim: true)
    |> Enum.map(&parse_line/1)
  end

  defp parse_line(<<"addx ", value::binary>>) do
    {:addx, String.to_integer(value)}
  end

  defp parse_line(<<"noop">>) do
    :noop
  end

  defp print_crt(crt), do: crt |> Enum.map(&Enum.join(&1)) |> Enum.join("\n")
end
