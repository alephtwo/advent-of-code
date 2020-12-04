defmodule Day01 do
  @moduledoc """
  Day 1 of Advent of Code 2020.
  """
  @input File.read!("priv/01.txt")
         |> String.split("\n", trim: true)
         |> Enum.map(&String.to_integer(&1))

  def part_one do
    process_expense_report(@input)
  end

  def process_expense_report(entries) when is_list(entries) do
    Enum.sum(entries)
  end
end
