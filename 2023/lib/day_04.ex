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

    card_values = cards |> Enum.map(fn c -> {c.number, count_winners(c)} end) |> Map.new()
    # start with one card of each in the deck
    card_counts = cards |> Enum.map(fn c -> {c.number, 1} end) |> Map.new()

    final = play_deck(1, card_counts, card_values)
    final |> Map.values() |> Enum.sum()
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

  defp play_deck(n, counts, _) when n > map_size(counts), do: counts

  defp play_deck(card_number, card_counts, card_values) do
    # how many cards does this card get us
    winners = Map.get(card_values, card_number)

    # which cards do those represent?
    new_card_counts =
      case winners do
        # we didn't win any new cards
        0 ->
          card_counts

        # we won some new cards, add them to the counts
        n ->
          # this is the range of cards that we won
          counts_to_update =
            (card_number + 1)..(card_number + n)
            # for each of those cards, add the count of the current card to it
            |> Enum.map(fn i ->
              {i, Map.get(card_counts, i) + Map.get(card_counts, card_number)}
            end)
            |> Map.new()

          Map.merge(card_counts, counts_to_update)
      end

    play_deck(card_number + 1, new_card_counts, card_values)
  end
end
