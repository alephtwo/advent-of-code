defmodule Day02 do
  @moduledoc """
  Day Two of Advent of Code 2018.
  """
  @external_resource "priv/02.txt"
  @input File.read!("priv/02.txt")

  def solve do
    IO.puts(part_one(parse_input()))
    IO.puts(part_two(parse_input()))
  end

  def part_one(input) when is_list(input) do
    input
    |> Enum.map(&char_counts/1)
    |> Enum.map(fn c -> [Map.has_key?(c, 2), Map.has_key?(c, 3)] end)
    |> Enum.reduce([0, 0], fn [has_two, has_three], [twos, threes] ->
      [
        if(has_two, do: twos + 1, else: twos),
        if(has_three, do: threes + 1, else: threes)
      ]
    end)
    |> Enum.reduce(&Kernel.*/2)
  end

  def part_two(input) when is_list(input) do
  end

  def char_counts(id) do
    characters = String.split(id, "", trim: true)

    characters
    |> Enum.group_by(fn x -> Enum.count(characters, fn y -> y == x end) end)
  end

  def parse_input do
    String.split(@input, "\n", trim: true)
  end
end
