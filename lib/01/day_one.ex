defmodule DayOne do
  @external_resource "priv/01/input.txt"
  @input File.read! "priv/01/input.txt"

  def solve do
    numbers = get_input()
    IO.puts part_one(numbers)
    IO.puts part_two(numbers)
  end

  def part_one(numbers) do
    matches_next = fn n -> (Enum.at(numbers, n) == Enum.at(numbers, n + 1)) end
    captcha(numbers, matches_next)
  end

  def part_two(numbers) do
    halfway_around = div(Enum.count(numbers), 2)
    matches_halfway_around = fn n ->
      Enum.at(numbers, n) == Enum.at(numbers, n + halfway_around)
    end
    captcha(numbers, matches_halfway_around)
  end

  defp captcha(numbers, filter) do
    count = Enum.count(numbers)
    (-count .. -1)
      |> Enum.filter(filter)
      |> Enum.map(fn x -> Enum.at(numbers, x) end)
      |> Enum.reduce(0, &Kernel.+/2)
  end

  def get_input do
    @input
    |> String.trim
    |> String.split("", trim: true)
    |> Enum.map(&Integer.parse/1)
    |> Enum.map(fn {x, _} -> x end)
  end
end
