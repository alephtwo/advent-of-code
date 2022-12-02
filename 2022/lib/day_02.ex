defmodule Day02 do

  @point_values %{
    rock: 1,
    paper: 2,
    scissors: 3
  }

  @spec part_one(String.t()) :: number()
  def part_one(input) do
    input
    |> parse_input()
    |> Enum.map(fn line ->
      Enum.map(line, fn c ->
        # decoding table
        case c do
          "A" -> {:opponent, :rock}
          "B" -> {:opponent, :paper}
          "C" -> {:opponent, :scissors}
          "X" -> {:player, :rock}
          "Y" -> {:player, :paper}
          "Z" -> {:player, :scissors}
        end
      end)
    end)
    |> Enum.map(&resolve_points_naive/1)
    |> Enum.sum
  end

  @spec part_two(String.t()) :: number()
  def part_two(input) do
    input
    |> parse_input()
    |> Enum.map(fn line ->
      Enum.map(line, fn c ->
        case c do
          "A" -> {:opponent, :rock}
          "B" -> {:opponent, :paper}
          "C" -> {:opponent, :scissors}
          "X" -> {:player, :lose}
          "Y" -> {:player, :draw}
          "Z" -> {:player, :win}
        end
      end)
    end)
    |> Enum.map(&resolve_points_enlightened/1)
    |> Enum.sum
  end

  defp parse_input(input) do
    input
    |> String.split("\n", trim: true)
    |> Enum.map(&String.split(&1, " "))
  end

  defp resolve_points_naive([{:opponent, opponent}, {:player, player}]) do
    victory_points = case player do
      :rock when opponent == :rock -> 3
      :rock when opponent == :paper -> 0
      :rock when opponent == :scissors -> 6
      :paper when opponent == :rock -> 6
      :paper when opponent == :paper -> 3
      :paper when opponent == :scissors -> 0
      :scissors when opponent == :rock -> 0
      :scissors when opponent == :paper -> 6
      :scissors when opponent == :scissors -> 3
    end

    victory_points + Map.get(@point_values, player)
  end

  defp resolve_points_enlightened([{:opponent, opponent}, {:player, condition}]) do
    player = case condition do
      :lose when opponent == :rock -> :scissors
      :lose when opponent == :paper -> :rock
      :lose when opponent == :scissors -> :paper
      :draw -> opponent
      :win when opponent == :rock -> :paper
      :win when opponent == :paper -> :scissors
      :win when opponent == :scissors -> :rock
    end

    victory_points = case condition do
      :lose -> 0
      :draw -> 3
      :win -> 6
    end

    victory_points + Map.get(@point_values, player)
  end
end
