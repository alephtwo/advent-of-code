defmodule Day04 do
  @moduledoc """
  Day Four of Advent of Code 2018.
  """
  @external_resource "priv/04.txt"
  @input File.read!("priv/04.txt") |> String.split("\n", trim: true)

  def part_one, do: part_one(@input)

  def part_one(input) do
    input
    |> parse_input()
  end

  def part_two, do: part_two(@input)

  def part_two(_input) do
  end

  defp parse_input(input) do
    input
    |> Enum.map(&parse_line/1)
    |> Enum.sort_by(fn x -> x.timestamp end)
    |> Enum.reduce([], &propagate_ids/2)
    |> Enum.reverse()
  end

  defp parse_line(line) do
    parsed = Regex.named_captures(~r/^\[(?<time>.*?)\] (?<action>.*?)$/, line)

    fake_iso_date = parsed["time"] <> ":00Z"
    {:ok, timestamp, _} = DateTime.from_iso8601(fake_iso_date)

    {id, action} = parse_action(parsed["action"])
    %{id: id, action: action, timestamp: timestamp}
  end

  defp parse_action(action) do
    cond do
      action =~ "Guard" -> parse_guard_id(action)
      action == "falls asleep" -> {nil, :sleep}
      action == "wakes up" -> {nil, :wake}
    end
  end

  defp parse_guard_id(action) do
    captures = Regex.named_captures(~r/^Guard #(?<id>\d+)/, action)
    {String.to_integer(captures["id"]), :start}
  end

  defp propagate_ids(entry, entries) do
    id = if entry.id == nil, do: List.first(entries).id, else: entry.id
    [Map.put(entry, :id, id) | entries]
  end
end
