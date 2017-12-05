defmodule DayFive do
  @external_resource "priv/05.txt"
  @input File.read! "priv/05.txt"

  def solve do
    IO.puts part_one()
    IO.puts part_two(parse_file())
  end

  def part_one, do: steps_to_escape(parse_file())

  def part_two(input) do

  end

  def steps_to_escape(input) do
    
  end

  def parse_file do
    @input
    |> String.split("\n", trim: true)
    |> Enum.map(&String.to_integer/1)
  end
end
