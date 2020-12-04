defmodule Day01 do
  @moduledoc """
  Day 1 of Advent of Code 2020.
  """
  @input File.read!("priv/01.txt")
         |> String.split("\n", trim: true)
         |> Enum.map(&String.to_integer(&1))

  def part_one do
    find_product_of_pair(@input)
  end

  def find_product_of_pair(entries) do 
    [a, b] = find_pair_that_adds_to_2020(entries)
    a * b
  end

  def find_pair_that_adds_to_2020(entries) when is_list(entries) do
    pairs = for x <- entries, y <- entries, x != y, do: [x, y]
    pairs 
    |> Enum.filter(fn [x, y] -> x + y == 2020 end)
    |> Enum.at(0)
  end
end
