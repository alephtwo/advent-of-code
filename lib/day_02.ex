defmodule DayTwo do
  @moduledoc """
  Advent of Code 2017 Day 2 solutions.
  """
  @external_resource "priv/02.txt"
  @input File.read! "priv/02.txt"
  def file_input, do: parse_spreadsheet(@input)

  def solve do
    IO.puts DayTwo.part_one(file_input())
    IO.puts DayTwo.part_two(file_input())
  end

  def part_one(input) do
    input
    |> Enum.map(fn row -> Enum.max(row) - Enum.min(row) end)
    |> Enum.sum
  end

  def part_two(input) do
    input
    |> Enum.map(&Enum.sort/1)
    |> Enum.map(&Enum.reverse/1)
    |> Enum.map(&pairify/1)
    |> Enum.map(fn [a, b] -> div(a, b) end)
    |> Enum.sum
  end

  def parse_spreadsheet(input) do
    input
    |> String.split("\n", trim: true)
    |> Enum.map(&split_and_parse/1)
  end

  defp split_and_parse(str) do
    str
    |> String.split("\t", trim: true)
    |> Enum.map(&String.to_integer/1)
  end

  defp find_pair(row, {element, index}) do
    row
    |> Enum.with_index
    |> Enum.filter(fn {_, i} -> i != index end)
    |> Enum.map(fn {e, _} -> [element, e] end)
    |> Enum.filter(fn [a, b] -> rem(a, b) == 0 end)
    |> List.flatten
  end

  defp pairify(row) do
    row
    |> Enum.with_index
    |> Enum.map(fn i -> find_pair(row, i) end)
    |> Enum.filter(&Enum.any?/1)
    |> List.flatten
  end
end
