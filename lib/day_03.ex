defmodule Day03 do
  @moduledoc """
  Day Three of Advent of Code 2018.
  """
  @external_resource "priv/03.txt"
  @input File.read!("priv/03.txt")

  def part_one, do: part_one(parse_input())

  def part_one(input) do
    claims = Enum.map(input, &parse_claim/1)
  end

  def part_two, do: part_two(parse_input())

  def part_two(_input) do
  end

  defp parse_input, do: String.split(@input, "\n", trim: true)

  defp parse_claim(claim) do
    Regex.named_captures(
      ~r/#(?<id>\d+) @ (?<left>\d+),(?<top>\d+): (?<height>\d+)x(?<width>\d+)/,
      claim
    )
  end
end
