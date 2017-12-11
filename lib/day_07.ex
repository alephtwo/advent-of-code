defmodule DaySeven do
  @external_resource "priv/07.txt"
  @input File.read! "priv/07.txt"

  def parse_string(string) do
    tokens = String.split(string, "-> ", trim: true)

    disc = parse_name_and_weight(Enum.at(tokens, 0))
    Map.put(disc, :children, parse_children(Enum.at(tokens, 1)))
  end

  defp parse_name_and_weight(string) do
    [[_, name, weight]] = Regex.scan(~r/^(.*)? \((\d+)\)/, string)
    %{ name: name, weight: String.to_integer(weight) }
  end

  defp parse_children(nil), do: []
  defp parse_children(s), do: String.split(s, ", ", trim: true)
end
