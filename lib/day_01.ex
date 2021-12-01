defmodule Day01 do
  @input File.read!("priv/01.txt")

  def part_one(input \\ @input) do
    depths = input |> parse_input

    depths
    |> Enum.with_index()
    |> Enum.map(fn {x, i} -> if x > Enum.at(depths, i - 1), do: 1, else: 0 end)
    |> Enum.sum()
  end

  def part_two(input \\ @input) do
    depths = parse_input(input)

    {first_window, depths} = Enum.split(depths, 3)

    depths
    |> Enum.reduce(%{sum: 0, window: first_window}, fn n, acc ->
      next_window = acc.window |> Enum.drop(1) |> Enum.concat([n])

      case Enum.sum(next_window) > Enum.sum(acc.window) do
        true -> %{sum: acc.sum + 1, window: next_window}
        false -> %{sum: acc.sum, window: next_window}
      end
    end)
    |> Map.get(:sum)
  end

  defp parse_input(raw) do
    raw
    |> String.split("\n", trim: true)
    |> Enum.map(&String.to_integer/1)
  end
end
