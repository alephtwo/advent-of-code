defmodule DayFour do
  @external_resource "priv/04.txt"
  @input File.read! "priv/04.txt"

  def solve do
    IO.puts part_one(parse_file())
  end

  def part_one(input) do
    input |> Enum.filter(&contains_no_duplicate_words/1) |> Enum.count
  end

  def contains_no_duplicate_words(passphrase) do
    tokens = String.split(passphrase, " ", trim: true)
    Enum.count(tokens |> Enum.uniq) == Enum.count(tokens)
  end

  def parse_file do
    @input |> String.split("\n", trim: true)
  end
end
