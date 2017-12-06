defmodule DaySix do
  @external_resource "priv/06.txt"
  @input File.read! "priv/06.txt"

  def part_one, do: steps_to_detect_infinite_loop(test_data())

  def steps_to_detect_infinite_loop(banks) do
    IO.inspect banks
  end

  defp test_data, do: @input |> String.trim |> String.split("\t", trim: true)
end
