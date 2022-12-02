defmodule Day02 do
  @moduledoc """
  Day 2 of Advent of Code 2022.
  """
  @point_values %{
    rock: 1,
    paper: 2,
    scissors: 3
  }

  @victory_points %{
    lose: 0,
    draw: 3,
    win: 6
  }

  @end_states %{
    %{player: :rock, opponent: :rock} => :draw,
    %{player: :rock, opponent: :paper} => :lose,
    %{player: :rock, opponent: :scissors} => :win,
    %{player: :paper, opponent: :rock} => :win,
    %{player: :paper, opponent: :paper} => :draw,
    %{player: :paper, opponent: :scissors} => :lose,
    %{player: :scissors, opponent: :rock} => :lose,
    %{player: :scissors, opponent: :paper} => :win,
    %{player: :scissors, opponent: :scissors} => :draw
  }

  @doc """
  The Elves begin to set up camp on the beach. To decide whose tent gets to be
  closest to the snack storage, a giant Rock Paper Scissors tournament is
  already in progress.

  Rock Paper Scissors is a game between two players. Each game contains many
  rounds; in each round, the players each simultaneously choose one of Rock,
  Paper, or Scissors using a hand shape. Then, a winner for that round is
  selected: Rock defeats Scissors, Scissors defeats Paper, and Paper defeats
  Rock. If both players choose the same shape, the round instead ends in a draw.

  Appreciative of your help yesterday, one Elf gives you an encrypted strategy
  guide (your puzzle input) that they say will be sure to help you win. "The
  first column is what your opponent is going to play: `A` for Rock, `B` for
  Paper, and `C` for Scissors. The second column--" Suddenly, the Elf is called
  away to help with someone's tent.

  The second column, you reason, must be what you should play in response: `X`
  for Rock, `Y` for Paper, and `Z` for Scissors. Winning every time would be
  suspicious, so the responses must have been carefully chosen.

  The winner of the whole tournament is the player with the highest score. Your
  total score is the sum of your scores for each round. The score for a single
  round is the score for the shape you selected (`1` for Rock, `2` for Paper,
  and `3` for Scissors) plus the score for the outcome of the round (`0` if you
  lost, `3` if the round was a draw, and 6 if you won).

  Since you can't be sure if the Elf is trying to help you or trick you, you
  should calculate the score you would get if you were to follow the strategy
  guide.

  For example, suppose you were given the following strategy guide:

  ```text
  A Y
  B X
  C Z
  ```

  This strategy guide predicts and recommends the following:

  * In the first round, your opponent will choose Rock (`A`), and you should
      choose Paper (`Y`). This ends in a win for you with a score of `8` (`2`
      because you chose Paper + `6` because you won).
  * In the second round, your opponent will choose Paper (`B`), and you should
      choose Rock (`X`). This ends in a loss for you with a score of `1`
      (1 + 0).
  * The third round is a draw with both players choosing Scissors, giving you a
      score of 3 + 3 = 6.

  In this example, if you were to follow the strategy guide, you would get a
  total score of `15` (8 + 1 + 6).

  What would your total score be if everything goes exactly according to your
  strategy guide?
  """
  @spec part_one(String.t()) :: number()
  def part_one(input) do
    decode = fn c ->
      case c do
        "A" -> :rock
        "B" -> :paper
        "C" -> :scissors
        "X" -> :rock
        "Y" -> :paper
        "Z" -> :scissors
      end
    end

    input
    |> parse_input()
    |> Enum.map(fn line -> Enum.map(line, decode) end)
    |> Enum.map(&resolve_points_naive/1)
    |> Enum.sum()
  end

  @doc """
  The Elf finishes helping with the tent and sneaks back over to you. "Anyway,
  the second column says how the round needs to end: `X` means you need to lose,
  `Y` means you need to end the round in a draw, and `Z` means you need to win.
  Good luck!"

  The total score is still calculated in the same way, but now you need to
  figure out what shape to choose so the round ends as indicated. The example
  above now goes like this:

  * In the first round, your opponent will choose Rock (`A`), and you need the
      round to end in a draw (`Y`), so you also choose Rock. This gives you a
      score of 1 + 3 = 4.
  * In the second round, your opponent will choose Paper (`B`), and you choose
      Rock so you lose (`X`) with a score of 1 + 0 = 1.
  * In the third round, you will defeat your opponent's Scissors with Rock for a
      score of 1 + 6 = 7.

  Now that you're correctly decrypting the ultra top secret strategy guide, you
  would get a total score of `12`.

  Following the Elf's instructions for the second column, what would your total
  score be if everything goes exactly according to your strategy guide?
  """
  @spec part_two(String.t()) :: number()
  def part_two(input) do
    decode = fn c ->
      case c do
        "A" -> {:opponent, :rock}
        "B" -> {:opponent, :paper}
        "C" -> {:opponent, :scissors}
        "X" -> {:player, :lose}
        "Y" -> {:player, :draw}
        "Z" -> {:player, :win}
      end
    end

    input
    |> parse_input()
    |> Enum.map(fn line -> Enum.map(line, decode) end)
    |> Enum.map(&resolve_points_enlightened/1)
    |> Enum.sum()
  end

  defp parse_input(input) do
    input
    |> String.split("\n", trim: true)
    |> Enum.map(&String.split(&1, " "))
  end

  defp resolve_points_naive([opponent, player]) do
    end_state = Map.get(@end_states, %{player: player, opponent: opponent})
    Map.get(@victory_points, end_state) + Map.get(@point_values, player)
  end

  defp resolve_points_enlightened([{:opponent, opponent}, {:player, condition}]) do
    # Look in the end states for the throw to make that forces the condition
    player =
      @end_states
      |> Enum.filter(fn {_, c} -> condition == c end)
      |> Enum.find_value(fn {%{opponent: o, player: p}, _} ->
        if o == opponent, do: p, else: nil
      end)

    Map.get(@victory_points, condition) + Map.get(@point_values, player)
  end
end
