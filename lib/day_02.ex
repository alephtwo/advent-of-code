defmodule Day02 do
  def part_one(input) do
    {x, y} =
      input
      |> parse_input
      |> Enum.reduce({0, 0}, fn instruction, {x, y} ->
        case instruction do
          %{direction: "forward", amplitude: a} -> {x + a, y}
          %{direction: "down", amplitude: a} -> {x, y + a}
          %{direction: "up", amplitude: a} -> {x, y - a}
        end
      end)

    x * y
  end

  def part_two(input) do
    input
    |> parse_input
  end

  defp parse_input(raw) do
    raw
    |> String.split("\n", trim: true)
    |> Enum.map(fn line ->
      [direction, amplitude] = String.split(line, " ")
      %{direction: direction, amplitude: String.to_integer(amplitude)}
    end)
  end
end
