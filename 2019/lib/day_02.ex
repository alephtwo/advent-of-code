defmodule Day02 do
  @moduledoc """
  Day 2 of Advent of Code 2019.
  """
  @input File.read!("priv/02.txt")
         |> String.trim()
         |> String.split(",", trim: true)
         |> Enum.map(&String.to_integer(&1))

  @doc """
  Run Day 2, Part 1.
  """
  def part_one do
    @input
    |> List.replace_at(1, 12)
    |> List.replace_at(2, 2)
    |> IntcodeComputer.run_program()
  end

  @doc """
  Run Day 2, Part 2.
  """
  def part_two do
    # Brute force it
    range = 1..100

    {noun, verb} =
      Enum.flat_map(range, fn noun ->
        Enum.map(range, fn verb -> part_two_inner(@input, noun, verb) end)
      end)
      |> Enum.filter(fn x -> x != nil end)
      |> Enum.at(0)

    # Do the thing
    100 * noun + verb
  end

  defp part_two_inner(input, noun, verb) do
    ran =
      input
      |> List.replace_at(1, noun)
      |> List.replace_at(2, verb)
      |> IntcodeComputer.run_program()

    if Enum.at(ran, 0) == 19_690_720 do
      {noun, verb}
    end
  end
end
