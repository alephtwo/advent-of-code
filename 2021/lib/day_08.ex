defmodule Day08 do
  @moduledoc """
  Day 8 of the Advent of Code 2021.
  """
  # Digits with known lengths.
  # length => digit
  @known_lengths %{
    2 => 1,
    4 => 4,
    3 => 7,
    7 => 8
  }

  @spec part_one(String.t()) :: integer()
  def part_one(input) do
    input
    |> parse_input()
    |> Enum.flat_map(&Map.get(&1, :output))
    |> Enum.map(fn x -> Map.get(@known_lengths, Enum.count(x)) end)
    |> Enum.filter(fn x -> x != nil end)
    |> Enum.count()
  end

  @spec part_two(String.t()) :: integer()
  def part_two(input) do
    input
    |> parse_input()
    |> Enum.map(&translate_output/1)
    |> Enum.sum()
  end

  defp parse_input(raw) do
    raw
    |> String.split("\n", trim: true)
    |> Enum.map(&parse_signal_line/1)
  end

  defp parse_signal_line(line) do
    [signals, output] =
      line
      |> String.split(" | ", trim: true)
      |> Enum.map(&convert_tokens_to_sets/1)

    %{signals: signals, output: output}
  end

  defp convert_tokens_to_sets(string) do
    string
    |> String.split(" ", trim: true)
    |> Enum.map(&MapSet.new(String.graphemes(&1)))
  end

  defp translate_output(%{signals: signals, output: output}) do
    dictionary = build_dictionary(signals)

    output
    |> Enum.map_join(&Map.get(dictionary, &1, 0))
    |> String.to_integer()
  end

  # credo:disable-for-next-line
  defp build_dictionary(signals) do
    # Start by finding the signals for our digits of known lengths.
    [one] = find_signals_by_length(signals, 2)
    [four] = find_signals_by_length(signals, 4)
    [seven] = find_signals_by_length(signals, 3)
    [eight] = find_signals_by_length(signals, 7)

    # Now we need to break down which segments map to what.
    #   aaaa
    #  b    c
    #  b    c
    #   dddd
    #  e    f
    #  e    f
    #   gggg

    # Segment A is 7 - 1.
    seg_a = Enum.at(MapSet.difference(seven, one), 0)

    # Adding segment A to 4 will produce something like 9.
    # Use that to find segment g, and thus 9.
    nine_without_seg_g = MapSet.put(four, seg_a)

    [{nine, seg_g}] =
      find_signals_that_are_superset_with_one_additional_segment(signals, nine_without_seg_g)

    # Adding Segment G to 7 will produce something like 3.
    # Use that to find segment d, and thus 3.
    three_without_seg_d = MapSet.put(seven, seg_g)

    [{three, seg_d}] =
      find_signals_that_are_superset_with_one_additional_segment(signals, three_without_seg_d)

    # Take segment D away from 8 and you get zero.
    zero = MapSet.delete(eight, seg_d)

    # 4 minus 1 and segment d is segment b.
    seg_b =
      four
      |> MapSet.difference(one)
      |> MapSet.delete(seg_d)
      |> Enum.at(0)

    # 0 minus 7, segment b, and segment g will give us segment e.
    seg_e =
      zero
      |> MapSet.difference(seven)
      |> MapSet.delete(seg_b)
      |> MapSet.delete(seg_g)
      |> Enum.at(0)

    # Some signal is 5. If we take 3 off of it, the only thing left will be seg b.
    # This is also true of 9 and 4 (which we know).
    [five] =
      Enum.filter(signals, fn s ->
        diff = MapSet.difference(s, three)
        diff == MapSet.new([seg_b]) && s != four && s != nine
      end)

    # 5 is very powerful.
    # Segment C is 8 minus 5 minus Segment E.
    seg_c =
      eight
      |> MapSet.difference(five)
      |> MapSet.delete(seg_e)
      |> Enum.at(0)

    # Now we just know two.
    two = MapSet.new([seg_a, seg_c, seg_d, seg_e, seg_g])

    # Six is 5 plus segment e.
    six = MapSet.put(five, seg_e)

    %{
      zero => 0,
      one => 1,
      two => 2,
      three => 3,
      four => 4,
      five => 5,
      six => 6,
      seven => 7,
      eight => 8,
      nine => 9
    }
  end

  defp find_signals_by_length(signals, length) do
    Enum.filter(signals, &(Enum.count(&1) == length))
  end

  defp find_signals_that_are_superset_with_one_additional_segment(signals, subset) do
    signals
    |> Enum.filter(&MapSet.subset?(subset, &1))
    |> Enum.map(fn s -> {s, MapSet.difference(s, subset)} end)
    |> Enum.filter(fn {_, d} -> Enum.count(d) == 1 end)
    |> Enum.map(fn {s, d} -> {s, Enum.at(d, 0)} end)
  end
end
