defmodule Day05 do
  @moduledoc """
  Day 5 of Advent of Code 2022.
  """

  @block_width 4
  @instruction_regex ~r/move (\d+) from (\d+) to (\d+)/

  @doc """
  The expedition can depart as soon as the final supplies have been unloaded
  from the ships. Supplies are stored in stacks of marked crates, but because
  the needed supplies are buried under many other crates, the crates need to be
  rearranged.

  The ship has a giant cargo crane capable of moving crates between stacks. To
  ensure none of the crates get crushed or fall over, the crane operator will
  rearrange them in a series of carefully-planned steps. After the crates are
  rearranged, the desired crates will be at the top of each stack.

  The Elves don't want to interrupt the crane operator during this delicate
  procedure, but they forgot to ask her which crate will end up where, and they
  want to be ready to unload them as soon as possible so they can embark.

  They do, however, have a drawing of the starting stacks of crates and the
  rearrangement procedure (your puzzle input). For example:

  ```text
      [D]
  [N] [C]
  [Z] [M] [P]
  1   2   3

  move 1 from 2 to 1
  move 3 from 1 to 3
  move 2 from 2 to 1
  move 1 from 1 to 2
  ```

  In this example, there are three stacks of crates. Stack 1 contains two
  crates: crate Z is on the bottom, and crate N is on top. Stack 2 contains
  three crates; from bottom to top, they are crates M, C, and D. Finally, stack
  3 contains a single crate, P.

  Then, the rearrangement procedure is given. In each step of the procedure, a
  quantity of crates is moved from one stack to a different stack. In the first
  step of the above rearrangement procedure, one crate is moved from stack 2 to
  stack 1, resulting in this configuration:

  ```text
  [D]
  [N] [C]
  [Z] [M] [P]
  1   2   3
  ```

  In the second step, three crates are moved from stack 1 to stack 3. Crates are
  moved one at a time, so the first crate to be moved (D) ends up below the
  second and third crates:

  ```text
          [Z]
          [N]
      [C] [D]
      [M] [P]
  1   2   3
  ```

  Then, both crates are moved from stack 2 to stack 1. Again, because crates are
  moved one at a time, crate C ends up below crate M:

  ```text
          [Z]
          [N]
  [M]     [D]
  [C]     [P]
  1   2   3
  ```

  Finally, one crate is moved from stack 1 to stack 2:

  ```text
          [Z]
          [N]
          [D]
  [C] [M] [P]
  1   2   3
  ```

  The Elves just need to know which crate will end up on top of each stack; in
  this example, the top crates are C in stack 1, M in stack 2, and Z in stack 3,
  so you should combine these together and give the Elves the message CMZ.

  After the rearrangement procedure completes, what crate ends up on top of each
  stack?
  """
  @spec part_one(String.t()) :: String.t()
  def part_one(input) do
    %{stacks: stacks, instructions: instructions} = parse_input(input)

    instructions
    |> Enum.reduce(stacks, &process_instruction/2)
    |> Enum.map_join(&Enum.at(&1, 0))
  end

  @doc """
  As you watch the crane operator expertly rearrange the crates, you notice the
  process isn't following your prediction.

  Some mud was covering the writing on the side of the crane, and you quickly
  wipe it away. The crane isn't a CrateMover 9000 - it's a CrateMover 9001.

  The CrateMover 9001 is notable for many new and exciting features: air
  conditioning, leather seats, an extra cup holder, and the ability to pick up
  and move multiple crates at once.

  Again considering the example above, the crates begin in the same
  configuration:

  ```text
      [D]
  [N] [C]
  [Z] [M] [P]
  1   2   3
  ```

  Moving a single crate from stack 2 to stack 1 behaves the same as before:

  ```text
  [D]
  [N] [C]
  [Z] [M] [P]
  1   2   3
  ```

  However, the action of moving three crates from stack 1 to stack 3 means that
  those three moved crates stay in the same order, resulting in this new
  configuration:

  ```text
          [D]
          [N]
      [C] [Z]
      [M] [P]
  1   2   3
  ```

  Next, as both crates are moved from stack 2 to stack 1, they retain their
  order as well:

  ```text
          [D]
          [N]
  [C]     [Z]
  [M]     [P]
  1   2   3
  ```

  Finally, a single crate is still moved from stack 1 to stack 2, but now it's
  crate C that gets moved:

  ```text
          [D]
          [N]
          [Z]
  [M] [C] [P]
  1   2   3
  ```

  In this example, the CrateMover 9001 has put the crates in a totally different
  order: MCD.

  Before the rearrangement process finishes, update your simulation so that the
  Elves know where they should stand to be ready to unload the final supplies.
  After the rearrangement procedure completes, what crate ends up on top of each
  stack?
  """
  @spec part_two(String.t()) :: String.t()
  def part_two(input) do
    %{stacks: stacks, instructions: instructions} = parse_input(input)

    instructions
    |> Enum.reduce(stacks, &process_instruction_enhanced/2)
    |> Enum.map_join(&Enum.at(&1, 0))
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
