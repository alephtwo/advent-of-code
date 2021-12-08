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

  defp build_dictionary(signals) do
    # Start by finding the signals for our digits of known lengths.
    %{1 => [one], 4 => [four], 7 => [seven], 8 => [eight]} = find_known_signals(signals)

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

    %{
      nine: nine,
      three: three,
      seg_g: seg_g,
      seg_d: seg_d
    } = find_nine_three_seg_g_seg_d(signals, four, seven, seg_a)

    %{
      zero: zero,
      two: two,
      five: five,
      six: six
    } =
      find_zero_two_five_six(
        signals,
        [one, three, four, seven, eight, nine],
        [seg_a, seg_d, seg_g]
      )

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

  defp find_known_signals(signals) do
    %{
      1 => find_signals_by_length(signals, 2),
      4 => find_signals_by_length(signals, 4),
      7 => find_signals_by_length(signals, 3),
      8 => find_signals_by_length(signals, 7)
    }
  end

  defp find_signals_by_length(signals, length) do
    Enum.filter(signals, &(Enum.count(&1) == length))
  end

  defp find_signal_that_is_superset_with_one_additional_segment(signals, subset) do
    [result] =
      signals
      |> Enum.filter(&MapSet.subset?(subset, &1))
      |> Enum.map(fn s -> {s, MapSet.difference(s, subset)} end)
      |> Enum.filter(fn {_, d} -> Enum.count(d) == 1 end)
      |> Enum.map(fn {s, d} -> {s, Enum.at(d, 0)} end)

    result
  end

  defp find_seg_b(four, one, seg_d) do
    four
    |> MapSet.difference(one)
    |> MapSet.delete(seg_d)
    |> Enum.at(0)
  end

  defp find_seg_e(zero, seven, seg_b, seg_g) do
    zero
    |> MapSet.difference(seven)
    |> MapSet.delete(seg_b)
    |> MapSet.delete(seg_g)
    |> Enum.at(0)
  end

  defp find_seg_c(eight, five, seg_e) do
    eight
    |> MapSet.difference(five)
    |> MapSet.delete(seg_e)
    |> Enum.at(0)
  end

  defp find_five(signals, three, four, nine, seg_b) do
    [five] =
      Enum.filter(signals, fn s ->
        diff = MapSet.difference(s, three)
        diff == MapSet.new([seg_b]) && s != four && s != nine
      end)

    five
  end

  defp find_nine_three_seg_g_seg_d(signals, four, seven, seg_a) do
    # Adding segment A to 4 will produce something like 9.
    # Use that to find segment g, and thus 9.
    {nine, seg_g} =
      find_signal_that_is_superset_with_one_additional_segment(signals, MapSet.put(four, seg_a))

    # Adding Segment G to 7 will produce something like 3.
    # Use that to find segment d, and thus 3.
    {three, seg_d} =
      find_signal_that_is_superset_with_one_additional_segment(signals, MapSet.put(seven, seg_g))

    %{
      nine: nine,
      seg_g: seg_g,
      three: three,
      seg_d: seg_d
    }
  end

  defp find_zero_two_five_six(signals, known_numbers, known_segments) do
    [one, three, four, seven, eight, nine] = known_numbers
    [seg_a, seg_d, seg_g] = known_segments

    # Take segment D away from 8 and you get zero.
    zero = MapSet.delete(eight, seg_d)

    # 4 minus 1 and segment d is segment b.
    seg_b = find_seg_b(four, one, seg_d)

    # 0 minus 7, segment b, and segment g will give us segment e.
    seg_e = find_seg_e(zero, seven, seg_b, seg_g)

    # Some signal is 5. If we take 3 off of it, the only thing left will be seg b.
    # This is also true of 9 and 4 (which we know).
    five = find_five(signals, three, four, nine, seg_b)

    # 5 is very powerful.
    # Segment C is 8 minus 5 minus Segment E.
    seg_c = find_seg_c(eight, five, seg_e)

    # Now we just know two.
    two = MapSet.new([seg_a, seg_c, seg_d, seg_e, seg_g])

    # Six is 5 plus segment e.
    six = MapSet.put(five, seg_e)

    %{
      zero: zero,
      two: two,
      five: five,
      six: six
    }
  end
end
