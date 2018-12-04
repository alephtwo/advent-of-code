defmodule DayOne do
  @external_resource "priv/01.txt"
  @input File.read!("priv/01.txt")

  def solve do
    IO.puts(part_one(parse_input()))
  end

  @doc """
  Day One, Part One.
  Accepts input as a list and performs the appropriate transformations.
  """
  def part_one(input) when is_list(input), do: Enum.sum(input)

  def parse_input do
    @input
    |> String.split("\n", trim: true)
    |> Enum.map(&String.to_integer(&1))
  end
end
