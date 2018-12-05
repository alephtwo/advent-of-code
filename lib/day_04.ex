defmodule Day04 do
  @moduledoc """
  Day Four of Advent of Code 2018.
  """
  @external_resource "priv/04.txt"
  @input File.read!("priv/04.txt") |> String.split("\n", trim: true)

  def part_one, do: part_one(@input)

  def part_one(input) do
    input
    |> Enum.map(&parse_line/1)
    |> IO.puts()
  end

  def part_two, do: part_two(@input)

  def part_two(_input) do
  end

  defp parse_line(line) do
    parsed = Regex.named_captures(~r/^\[(?<time>.*?)\] (?<action>.*?)$/, line)

    fake_iso_date = parsed["time"] <> ":00Z"
    {:ok, timestamp} = DateTime.from_iso8601(fake_iso_date)

    %{action: parsed["action"], timestamp: timestamp}
  end
end
