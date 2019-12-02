defmodule Day02 do
  @input File.read!("priv/02.txt")

  def part_one do
    @input
    |> parse_input()
    |> List.replace_at(1, 12)
    |> List.replace_at(2, 2)
    |> run_program()
  end

  # Handle string input by parsing it before running it
  def run_program(program) when is_binary(program) do
    program |> parse_input() |> run_program()
  end

  # Run the program
  def run_program(program, pc \\ 0) when is_list(program) do
    case do_instruction(Enum.slice(program, pc, 4), program) do
      {:stop, program} -> program
      {:continue, program} -> run_program(program, pc + 4)
    end
  end

  # When we don't have enough instructions we should just stop
  def do_instruction(i, program) when length(i) < 4, do: {:stop, program}
  # Perform the instruction
  def do_instruction([op, a, b, i], program) do
    first = Enum.at(program, a)
    second = Enum.at(program, b)
    case op do
      1 -> {:continue, List.replace_at(program, i, first + second)}
      2 -> {:continue, List.replace_at(program, i, first * second)}
      99 -> {:stop, program}
    end
  end

  def parse_input(input) do
    input
    |> String.trim()
    |> String.split(",", trim: true)
    |> Enum.map(&String.to_integer(&1))
  end
end
