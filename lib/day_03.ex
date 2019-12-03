defmodule Day03 do
  @input File.read!("priv/03.txt")
         |> String.split("\n", trim: true)
         |> Enum.map(fn x -> String.split(x, ",", trim: true) end)

  def part_one do
    min_manhattan_distance(@input)
  end

  def min_manhattan_distance(wires) when is_list(wires) do
    [first, second] = Enum.map(wires, fn wire ->
      Enum.reduce(wire, [{0, 0}], &reduce_path/2)
    end)

    first
    |> Enum.filter(fn x -> x != {0, 0} end)
    |> Enum.filter(fn x -> Enum.member?(second, x) end)
    |> Enum.map(fn {x, y} -> abs(x) + abs(y) end)
    |> Enum.min()
  end

  defp reduce_path(instruction, acc) do
    {x, y} = Enum.at(acc, -1)
    amount = instruction
             |> String.slice(1..-1)
             |> String.to_integer()
    directions =
      case String.first(instruction) do
        "U" -> ((y + 1)..(y + amount)) |> Enum.map(fn l -> {x, l} end)
        "D" -> ((y - 1)..(y - amount)) |> Enum.map(fn l -> {x, l} end)
        "R" -> ((x + 1)..(x + amount)) |> Enum.map(fn l -> {l, y} end)
        "L" -> ((x - 1)..(x - amount)) |> Enum.map(fn l -> {l, y} end)
      end
    acc ++ directions |> Enum.uniq
  end
end
