defmodule DayFive do
  @external_resource "priv/05.txt"
  @input File.read! "priv/05.txt"

  def solve do
    IO.puts part_one()
    IO.puts part_two(parse_file())
  end

  def part_one, do: steps_to_escape_part_one(parse_file())

  def part_two(input) do

  end

  def steps_to_escape_part_one(input) do
    execute_and_jump({input, 0, 0}, fn (i, jump) -> i + jump end)
  end

  def execute_and_jump({_, i, accum}, _) when i < 0, do: accum
  def execute_and_jump({ops, i, accum}, _) when i >= length(ops), do: accum
  def execute_and_jump({ops, i, accum}, calc_next) do
    jump = Enum.at(ops, i)
    new_ops = List.replace_at(ops, i, jump + 1)
    new_index = calc_next.(i, jump)

    execute_and_jump({new_ops, new_index, accum + 1}, calc_next)
  end

  def parse_file do
    @input
    |> String.split("\n", trim: true)
    |> Enum.map(&String.to_integer/1)
  end
end
