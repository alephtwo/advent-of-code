defmodule IntcodeComputer do
  @moduledoc """
  The Intcode Computer for Advent of Code 2019.
  """

  @doc """
  Run the program represented by the given memory.
  """
  @spec run_program(list) :: list
  def run_program(memory) when is_list(memory), do: run_program(memory, 0)

  defp run_program(memory, ic) when is_list(memory) do
    case execute(memory, ic) do
      {:stop, memory} -> memory
      {:continue, length, memory} -> run_program(memory, ic + length)
    end
  end

  defp execute(memory, ic) do
    opcode = Enum.at(memory, ic)
    length = instruction_length(opcode)
    inputs = Enum.slice(memory, (ic + 1)..(ic + length - 1))

    case opcode do
      1 -> {:continue, length, add(memory, inputs)}
      2 -> {:continue, length, multiply(memory, inputs)}
      99 -> {:stop, memory}
    end
  end

  defp instruction_length(opcode) do
    case opcode do
      1 -> 4
      2 -> 4
      3 -> 2
      4 -> 2
      99 -> 4
    end
  end

  defp add(memory, [a, b, i]) do
    List.replace_at(memory, i, Enum.at(memory, a) + Enum.at(memory, b))
  end

  defp multiply(memory, [a, b, i]) do
    List.replace_at(memory, i, Enum.at(memory, a) * Enum.at(memory, b))
  end
end
