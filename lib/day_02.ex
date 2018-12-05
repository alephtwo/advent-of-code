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
    {_, closest} =
      input
      |> Enum.flat_map(fn x -> Enum.map(input, fn y -> [x, y] end) end)
      |> Enum.filter(fn [l, r] -> l != r end)
      |> Enum.group_by(fn [l, r] -> simple_word_distance(l, r) end)
      |> Enum.filter(fn {c, _} -> c == 1 end)
      |> Enum.at(0)

    [first, second] =
      closest
      |> Enum.at(0)
      |> Enum.map(&String.split(&1, "", trim: true))

    first
    |> Enum.zip(second)
    |> Enum.filter(fn {x, y} -> x == y end)
    |> Enum.map(fn {x, _} -> x end)
    |> Enum.join("")
  end

  # This sure got needlessly complicated...
  def simple_word_distance(first, second) do
    mask =
      first
      |> string_to_binary
      |> Enum.zip(string_to_binary(second))
      |> Enum.map(fn {x, y} -> abs(x - y) end)
      |> drop_last

    Enum.count(mask, fn x -> x != 0 end)
  end

  def parse_input, do: String.split(@input, "\n", trim: true)

  defp char_counts(id) do
    characters = String.split(id, "", trim: true)

    characters
    |> Enum.group_by(fn x -> Enum.count(characters, fn y -> y == x end) end)
  end

  defp string_to_binary(word), do: :binary.bin_to_list(word <> <<0>>)

  defp drop_last(list) do
    [_ | tail] = Enum.reverse(list)
    Enum.reverse(tail)
  end
end
