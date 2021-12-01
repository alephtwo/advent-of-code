defmodule Day01 do
  @input File.read!("priv/01.txt")

  def part_one(input \\ @input) do
    depths = input |> parse_input

    depths
    |> Enum.with_index
    |> Enum.map(fn {x, i} -> if x > Enum.at(depths, i - 1), do: 1, else: 0 end)
    |> Enum.sum
  end

  def part_two(input \\ @input) do

  end

  defp parse_input(raw) do
    raw
    |> String.split("\n", trim: true)
    |> Enum.map(&String.to_integer/1)
  end
end
