defmodule Day01 do
  @input File.read!("priv/01.txt")

  def part_one(input \\ @input) do
    input
    |> parse_input
    |> Enum.reduce(%{sum: 0, prev: nil}, fn n, acc ->
      case n > acc.prev do
        true -> %{sum: acc.sum + 1, prev: n}
        false -> %{sum: acc.sum, prev: n}
      end
    end)
    |> Map.get(:sum)
  end

  def part_two(input \\ @input), do: nil

  defp parse_input(raw) do
    raw
    |> String.split("\n", trim: true)
    |> Enum.map(&String.to_integer/1)
  end
end
