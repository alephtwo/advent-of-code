defmodule Day05 do
  @moduledoc """
  Day 5 of Advent of Code 2022.
  """

  @block_width 4
  @instruction_regex ~r/move (\d+) from (\d+) to (\d+)/

  @doc """
  """
  @spec part_one(String.t()) :: String.t()
  def part_one(input) do
    %{stacks: stacks, instructions: instructions} = parse_input(input)

    instructions
    |> Enum.reduce(stacks, &process_instruction/2)
    |> Enum.map(&Enum.at(&1, 0))
    |> Enum.join()
  end

  @doc """
  """
  @spec part_two(String.t()) :: String.t()
  def part_two(input) do
    %{stacks: stacks, instructions: instructions} = parse_input(input)

    instructions
    |> Enum.reduce(stacks, &process_instruction_enhanced/2)
    |> Enum.map(&Enum.at(&1, 0))
    |> Enum.join()
  end

  defp parse_input(input) do
    # Split into two halves. First is the def, next is the instructions
    [preamble, instructions] = String.split(input, "\n\n", trim: true)

    [cols | reversed_lines] = String.split(preamble, "\n") |> Enum.reverse()

    last_col =
      cols
      |> String.split(" ", trim: true)
      |> Enum.map(&String.to_integer/1)
      |> Enum.max()

    # determine the width in characters of the blocks
    width = @block_width * last_col

    rows =
      reversed_lines
      |> Enum.reverse()
      |> Enum.map(&String.pad_trailing(&1, width))
      |> Enum.map(fn string ->
        string
        |> String.codepoints()
        |> Enum.chunk_every(4)
        |> Enum.map(&Enum.join/1)
        |> Enum.map(&parse_block/1)
      end)

    stacks =
      Enum.map(1..last_col, fn i ->
        rows
        |> Enum.map(fn r -> Enum.at(r, i - 1) end)
        |> Enum.filter(fn r -> r != nil end)
      end)

    %{
      stacks: stacks,
      instructions:
        instructions
        |> String.split("\n", trim: true)
        |> Enum.map(&parse_instruction/1)
    }
  end

  defp parse_instruction(line) do
    [_, amount, src, dest] = Regex.run(@instruction_regex, line)

    %{
      amount: String.to_integer(amount),
      src: String.to_integer(src),
      dest: String.to_integer(dest)
    }
  end

  defp parse_block(block) do
    # whatever is at index 1 determines what this is
    thing =
      block
      |> String.graphemes()
      |> Enum.at(1)

    if thing == " ", do: nil, else: thing
  end

  defp process_instruction(instruction, stacks) do
    moving =
      stacks
      |> Enum.at(instruction.src - 1)
      |> Enum.take(instruction.amount)
      |> Enum.reverse()

    stacks
    |> List.update_at(instruction.src - 1, &Enum.drop(&1, instruction.amount))
    |> List.update_at(instruction.dest - 1, fn x -> moving ++ x end)
  end

  defp process_instruction_enhanced(instruction, stacks) do
    # the enhanced crane can pull multiples in order
    moving =
      stacks
      |> Enum.at(instruction.src - 1)
      |> Enum.take(instruction.amount)

    stacks
    |> List.update_at(instruction.src - 1, &Enum.drop(&1, instruction.amount))
    |> List.update_at(instruction.dest - 1, fn x -> moving ++ x end)
  end
end
