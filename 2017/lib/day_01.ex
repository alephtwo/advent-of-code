defmodule DayOne do
  @moduledoc """
  Advent of Code 2017 Day 1 solutions.
  """
  @external_resource "priv/01.txt"
  @input File.read! "priv/01.txt"

  def solve do
    numbers = get_input()
    IO.puts part_one(numbers)
    IO.puts part_two(numbers)
  end

  @spec part_one(list) :: number
  def part_one(numbers) do
    matches_next = fn n -> (Enum.at(numbers, n) == Enum.at(numbers, n + 1)) end
    captcha(numbers, matches_next)
  end

  @spec part_two(list) :: number
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
