defmodule Day07 do
  @moduledoc """
  Day 7 of Advent of Code 2020.
  """

  @input File.read!("priv/07.txt")

  def part_one(input \\ @input) do
    input
    |> parse_graph()
    |> IO.inspect()
  end

  def part_two(input \\ @input), do: input

  defp parse_graph(input) do
    input
    |> String.split("\n", trim: true)
    |> Enum.map(&parse_rule/1)
    |> build_graph()
  end

  defp parse_rule(text) do
    [type, contents] = String.split(text, " contain ", trim: true)

    %{
      # Remove " bags" because it will appear in everything.
      type: String.replace(type, ~r/ bags?/, ""),
      rules: parse_contents(contents)
    }
  end

  defp build_graph(rules) do
    graph = :digraph.new()

    # Add all nodes to the graph.
    # Assume every type of bag has a line in the file...
    rules
    |> Enum.map(fn r -> r.type end)
    |> Enum.each(fn t -> :digraph.add_vertex(graph, t) end)

    # Ok, now add all edges.
    rules
    |> Enum.map(fn node ->
      Enum.each(node.rules, fn rule ->
        rule.color
        |> List.duplicate(rule.amount)
        |> Enum.each(fn color -> :digraph.add_edge(graph, node.type, color) end)
      end)
    end)
  end

  defp parse_contents(contents) do
    contents
    |> String.split(", ", trim: true)
    |> Enum.map(&parse_bag/1)
    |> Enum.filter(fn x -> x != :none end)
  end

  defp parse_bag(bag) do
    if bag == "no other bags." do
      :none
    else
      regex = ~r/(?<amount>\d+) (?<color>.*?) bags?\.?/
      caps = Regex.named_captures(regex, bag)
      %{color: Map.get(caps, "color"), amount: caps |> Map.get("amount") |> String.to_integer()}
    end
  end
end
