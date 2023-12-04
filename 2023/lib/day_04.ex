defmodule AdventOfCode2023.Day04 do
  @moduledoc """
  """

  defmodule Card do
    @moduledoc """
    Represents a game card.
    """
    defstruct number: nil, winning_numbers: [], chosen_numbers: []
  end

  @doc """
  """
  def part_one(input) do
    input
    |> parse_input()
    |> Enum.map(&score_card/1)
    |> Enum.sum()
  end

  @doc """
  """
  def part_two(input) do
    input
    |> parse_input()
  end

  defp parse_input(input) do
    input
    |> String.split("\n", trim: true)
    |> Enum.map(&parse_card/1)
  end

  defp parse_card(line) do
    [_, number, winning, chosen] = Regex.run(~r/^Card\s+(\d+):\s+([ \d]*)\|\s+([ \d]*)$/, line)

    %Card{
      number: number |> Integer.parse() |> elem(0),
      winning_numbers: string_to_list_of_numbers(winning),
      chosen_numbers: string_to_list_of_numbers(chosen)
    }
  end

  defp string_to_list_of_numbers(string) do
    string
    |> String.split(" ", trim: true)
    |> Enum.map(fn n -> n |> Integer.parse() |> elem(0) end)
  end

  defp score_card(card = %Card{}) do
    chosen = MapSet.new(card.chosen_numbers)
    winning = MapSet.new(card.winning_numbers)

    winners = MapSet.intersection(chosen, winning)

    case Enum.count(winners) do
      0 -> 0
      n -> 2 ** (n - 1)
    end
  end
end
