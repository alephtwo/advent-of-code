defmodule DayFour do
  @moduledoc """
  Advent of Code 2017 Day 4 solutions.
  """
  @external_resource "priv/04.txt"
  @input File.read! "priv/04.txt"

  def solve do
    IO.puts part_one(parse_file())
    IO.puts part_two(parse_file())
  end

  def part_one(input) do
    input |> Enum.filter(&contains_no_duplicate_words/1) |> Enum.count
  end

  def part_two(input) do
    input |> Enum.filter(&contains_no_anagrams/1) |> Enum.count
  end

  def contains_no_duplicate_words(passphrase) do
    tokens = split_passphrase(passphrase)
    Enum.count(tokens |> Enum.uniq) == Enum.count(tokens)
  end

  def contains_no_anagrams(passphrase) do
    tokens = split_passphrase(passphrase)
    words = Enum.map(tokens, &alphabetize_word/1)
    Enum.count(words |> Enum.uniq) == Enum.count(tokens)
  end

  def parse_file do
    @input |> String.split("\n", trim: true)
  end

  defp split_passphrase(p), do: String.split(p, " ", trim: true)
  defp alphabetize_word(word) do
    word
    |> String.split("", trim: true)
    |> Enum.sort
    |> Enum.join("")
  end
end
