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
    cards = parse_input(input)

    card_values =
      cards
      |> Enum.map(fn c -> {c.number, count_winners(c)} end)
      |> Map.new()

    deck = Enum.map(cards, fn c -> c.number end)

    final = play_deck(deck, deck, card_values)
    Enum.count(final)
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
    case count_winners(card) do
      0 -> 0
      n -> 2 ** (n - 1)
    end
  end

  defp count_winners(card = %Card{}) do
    chosen = MapSet.new(card.chosen_numbers)
    winning = MapSet.new(card.winning_numbers)
    chosen |> MapSet.intersection(winning) |> Enum.count()
  end

  defp play_deck([], deck, _), do: deck

  defp play_deck([card | remaining], deck, card_values) do
    amount_won = Map.get(card_values, card)

    cards_won =
      case amount_won do
        0 -> []
        n -> Enum.to_list((card + 1)..(card + n))
      end

    play_deck(Enum.concat(remaining, cards_won), Enum.concat(deck, cards_won), card_values)
  end
end
