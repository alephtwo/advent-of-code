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
    patchwork = Enum.reduce(claims, surface_area, &populate_surface_area/2)

    patchwork
    |> Enum.map(&detect_overlaps_in_row/1)
    |> Enum.reduce(0, &Kernel.+/2)
  end

  def part_two, do: part_two(parse_input())

  def part_two(_input) do
  end

  defp parse_input, do: String.split(@input, "\n", trim: true)

  defp parse_claim(claim) do
    groups =
      Regex.named_captures(
        ~r/#(?<id>\d+) @ (?<left>\d+),(?<top>\d+): (?<width>\d+)x(?<height>\d+)/,
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

  defp populate_surface_area(claim, rows) do
    Enum.map(Enum.with_index(rows), fn {row, y} ->
      bottom = claim.top + claim.height

      if y < claim.top || y >= bottom do
        row
      else
        Enum.map(Enum.with_index(row), fn {col, x} ->
          right = claim.left + claim.width
          if x < claim.left || x >= right, do: col, else: col + 1
        end)
      end
    end)
  end

  defp detect_overlaps_in_row(row) do
    row
    |> Enum.map(fn x -> if x > 1, do: 1, else: 0 end)
    |> Enum.sum()
  end
end
