defmodule Day02 do
  @input File.read!("priv/02.txt")

  def part_one do
    run_program @input
  end

  def run_program(input) do
    program = parse_input(input)
              |> List.replace_at(1, 12)
              |> List.replace_at(2, 2)
  end

  defp parse_input(input) do
    input
    |> String.trim()
    |> String.split(",", trim: true)
    |> Enum.map(&String.to_integer(&1))
  end
end
