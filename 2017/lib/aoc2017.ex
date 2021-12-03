defmodule AdventOfCode2017 do
  @moduledoc """
  Advent of Code 2017 escript module.
  """
  @spec main(list()) :: none()
  def main(_args) do
    IO.puts DaySix.part_one()
    IO.puts DaySix.part_two()
  end
end
