defmodule DayFive do
  @external_resource "priv/05.txt"
  @input File.read! "priv/05.txt"

  def solve do
    IO.puts part_two()
  end

  def part_one do
     {accum, _} = steps_to_escape_part_one(parse_file())
     accum
  end
  def part_two do
    # Part Two is cursed and takes forever to run
    {accum, _} = steps_to_escape_part_two(parse_file())
    accum
  end

  def steps_to_escape_part_one(input) do
    execute_and_jump({input, 0, 0}, fn jump -> jump + 1 end)
  end

  def steps_to_escape_part_two(input) do
    execute_and_jump({input, 0, 0}, fn jump ->
      if jump >= 3, do: jump - 1, else: jump + 1
    end)
  end

  def execute_and_jump({ops, i, accum}, _) when i < 0 or i >= length(ops) do
    {accum, ops}
  end
  def execute_and_jump({ops, i, accum}, calc_next) do
    jump = Enum.at(ops, i)
    new_ops = List.replace_at(ops, i, calc_next.(jump))
    execute_and_jump({new_ops, i + jump, accum + 1}, calc_next)
  end

  def parse_file do
    @input
    |> String.split("\n", trim: true)
    |> Enum.map(&String.to_integer/1)
  end
end
