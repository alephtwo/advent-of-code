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
  def run_program(program) when is_list(program) do
    program
  end

  def parse_input(input) do
    input
    |> String.trim()
    |> String.split(",", trim: true)
    |> Enum.map(&String.to_integer(&1))
  end
end
