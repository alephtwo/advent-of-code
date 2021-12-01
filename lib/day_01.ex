defmodule Day01 do
  @input File.read!("priv/01.txt")

  def part_one(input \\ @input) do
    input
    |> parse_input
    |> Enum.chunk_every(2, 1, :discard)
    |> Enum.map(fn [a, b] -> if b > a, do: 1, else: 0 end)
    |> Enum.sum()
  end

  def part_two(input \\ @input) do
    input
    |> parse_input
    |> Enum.chunk_every(3, 1, :discard)
    |> Enum.chunk_every(2, 1, :discard)
    |> Enum.map(fn [a, b] -> if Enum.sum(b) > Enum.sum(a), do: 1, else: 0 end)
    |> Enum.sum()
  end

  defp parse_input(raw) do
    raw
    |> String.split("\n", trim: true)
    |> Enum.map(&String.to_integer/1)
  end
end
