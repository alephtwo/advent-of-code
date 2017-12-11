defmodule DaySeven do
  @moduledoc """
  Day Seven of AOC2017.
  """
  @external_resource "priv/07.txt"
  @input File.read! "priv/07.txt"

  def part_one do
    get_input()
    |> find_root
    |> IO.puts
  end

  @spec find_root(digraph) :: list(string)
  def find_root(graph) do
    graph
    |> :digraph.vertices
    |> Enum.filter(fn v -> :digraph.in_degree(graph, v) == 0 end)
  end

  defp add_vertex(graph, %{name: name}), do: :digraph.add_vertex(graph, name)
  defp add_edges(graph, %{name: name, children: children}) do
    Enum.each(children, fn child -> :digraph.add_edge(graph, name, child) end)
  end

  def get_input do
    @input
    |> String.split("\n", trim: true)
    |> Enum.map(&parse_string/1)
    |> build_graph
  end

  defp build_graph(input) do
    graph = :digraph.new()
    Enum.each(input, fn x -> add_vertex(graph, x) end)
    Enum.each(input, fn x -> add_edges(graph, x) end)
    graph
  end

  @spec parse_string(string) :: %{weight: number, name: string, children: list}
  def parse_string(string) do
    tokens = String.split(string, "-> ", trim: true)

    disc = parse_name_and_weight(Enum.at(tokens, 0))
    Map.put(disc, :children, parse_children(Enum.at(tokens, 1)))
  end

  defp parse_name_and_weight(string) do
    [[_, name, weight]] = Regex.scan(~r/^(.*)? \((\d+)\)/, string)
    %{name: name, weight: String.to_integer(weight)}
  end

  defp parse_children(nil), do: []
  defp parse_children(s), do: String.split(s, ", ", trim: true)
end
