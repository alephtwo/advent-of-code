defmodule Day03 do
  @moduledoc """
  Day Three of Advent of Code 2018.
  """
  @external_resource "priv/03.txt"
  @input File.read!("priv/03.txt")

  def part_one, do: part_one(parse_input())

  def part_one(input) do
    claims = Enum.map(input, &parse_claim/1)
    surface_area = matrix(required_height(claims), required_width(claims))
    Enum.reduce(claims, surface_area, &populate_surface_area/2)
  end

  def part_two, do: part_two(parse_input())

  def part_two(_input) do
  end

  defp parse_input, do: String.split(@input, "\n", trim: true)

  defp parse_claim(claim) do
    groups =
      Regex.named_captures(
        ~r/#(?<id>\d+) @ (?<left>\d+),(?<top>\d+): (?<height>\d+)x(?<width>\d+)/,
        claim
      )

    groups
    |> Map.new(fn {k, v} -> {String.to_atom(k), String.to_integer(v)} end)
  end

  defp matrix(rows, columns, default_value \\ 0) do
    1
    |> List.duplicate(rows)
    |> Enum.map(fn _ -> List.duplicate(default_value, columns) end)
  end

  defp required_width(claims) do
    claims
    |> Enum.map(fn claim -> claim.left + claim.width + 1 end)
    |> Enum.max()
  end

  defp required_height(claims) do
    claims
    |> Enum.map(fn claim -> claim.top + claim.height + 1 end)
    |> Enum.max()
  end

  defp populate_surface_area(claim, surface_area) do
    surface_area
  end
end
