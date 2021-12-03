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

  def part_two do
    find_product_of_triplet(@input)
  end

  def find_product_of_pair(entries) do
    entries
    |> find_pair_that_adds_to_2020
    |> Enum.reduce(&*/2)
  end

  def find_product_of_triplet(entries) do
    entries
    |> find_triplet_that_adds_to_2020
    |> Enum.reduce(&*/2)
  end

  def find_pair_that_adds_to_2020(entries) do
    pairs = for x <- entries, y <- entries, x != y, do: [x, y]
    find_entries_that_sum_to_2020(pairs)
  end

  def find_triplet_that_adds_to_2020(entries) do
    triplets = for x <- entries, y <- entries, z <- entries, x != y, y != z, x != z, do: [x, y, z]
    find_entries_that_sum_to_2020(triplets)
  end

  def find_entries_that_sum_to_2020(lists) do
    lists
    |> Stream.filter(&list_sum_equals_2020/1)
    |> Enum.take(1)
    |> List.flatten()
  end

  defp list_sum_equals_2020(list) do
    Enum.sum(list) == 2020
  end
end
