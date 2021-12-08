defmodule Day08 do
  @moduledoc """
  Day 8 of the Advent of Code 2021.
  """
  @type signal_t :: MapSet.t(String.t())
  @type parsed_line_t :: %{signals: list(signal_t()), output: list(signal_t())}
  @type translation_dictionary_t :: %{
          signal_t() => 0,
          signal_t() => 1,
          signal_t() => 2,
          signal_t() => 3,
          signal_t() => 4,
          signal_t() => 5,
          signal_t() => 6,
          signal_t() => 7,
          signal_t() => 8,
          signal_t() => 9
        }

  # Digits with known lengths.
  # length => digit
  @known_lengths %{
    2 => 1,
    4 => 4,
    3 => 7,
    7 => 8
  }

  @doc """
  You barely reach the safety of the cave when the whale smashes into the cave
  mouth, collapsing it. Sensors indicate another exit to this cave at a much
  greater depth, so you have no choice but to press on.

  As your submarine slowly makes its way through the cave system, you notice
  that the four-digit seven-segment displays in your submarine are
  malfunctioning; they must have been damaged during the escape. You'll be in a
  lot of trouble without them, so you'd better figure out what's wrong.

  Each digit of a seven-segment display is rendered by turning on or off any of
  seven segments named `a` through `g`:

  ```text
    0:      1:      2:      3:      4:
  aaaa    ....    aaaa    aaaa    ....
  b    c  .    c  .    c  .    c  b    c
  b    c  .    c  .    c  .    c  b    c
  ....    ....    dddd    dddd    dddd
  e    f  .    f  e    .  .    f  .    f
  e    f  .    f  e    .  .    f  .    f
  gggg    ....    gggg    gggg    ....

    5:      6:      7:      8:      9:
  aaaa    aaaa    aaaa    aaaa    aaaa
  b    .  b    .  .    c  b    c  b    c
  b    .  b    .  .    c  b    c  b    c
  dddd    dddd    ....    dddd    dddd
  .    f  e    f  .    f  e    f  .    f
  .    f  e    f  .    f  e    f  .    f
  gggg    gggg    ....    gggg    gggg
  ```

  So, to render a `1`, only segments `c` and `f` would be turned on; the rest
  would be off. To render a `7`, only segments `a`, `c`, and `f` would be turned
  on.

  The problem is that the signals which control the segments have been mixed up
  on each display. The submarine is still trying to display numbers by producing
  output on signal wires `a` through `g`, but those wires are connected to
  segments randomly. Worse, the wire/segment connections are mixed up separately
  for each four-digit display! (All of the digits within a display use the same
  connections, though.)

  So, you might know that only signal wires b and g are turned on, but that
  doesn't mean segments `b` and `g` are turned on: the only digit that uses two
  segments is `1`, so it must mean segments `c` and `f` are meant to be on. With
  just that information, you still can't tell which wire (`b`/`g`) goes to which
  segment (`c`/`f`). For that, you'll need to collect more information.

  For each display, you watch the changing signals for a while, make a note of
  all ten unique signal patterns you see, and then write down a single four
  digit output value (your puzzle input). Using the signal patterns, you should
  be able to work out which pattern corresponds to which digit.

  For example, here is what you might see in a single entry in your notes:

  ```text
  acedgfb cdfbe gcdfa fbcad dab cefabd cdfgeb eafb cagedb ab | cdfeb fcadb cdfeb cdbaf
  ```

  (The entry is wrapped here to two lines so it fits; in your notes, it will all
  be on a single line.)

  Each entry consists of ten unique signal patterns, a `|` delimiter, and
  finally the four digit output value. Within an entry, the same wire/segment
  connections are used (but you don't know what the connections actually are).
  The unique signal patterns correspond to the ten different ways the submarine
  tries to render a digit using the current wire/segment connections. Because
  `7` is the only digit that uses three segments, `dab` in the above example
  means that to render a `7`, signal lines `d`, `a`, and `b` are on. Because `4`
  is the only digit that uses four segments, `eafb` means that to render a `4`,
  signal lines `e`, `a`, `f`, and `b` are on.

  Using this information, you should be able to work out which combination of
  signal wires corresponds to each of the ten digits. Then, you can decode the
  four digit output value. Unfortunately, in the above example, all of the
  digits in the output value (cdfeb fcadb cdfeb cdbaf) use five segments and are
  more difficult to deduce.

  For now, focus on the easy digits. Consider this larger example:

  ```text
  be cfbegad cbdgef fgaecd cgeb fdcge agebfd fecdb fabcd edb | fdgacbe cefdb cefbgd gcbe
  edbfga begcd cbg gc gcadebf fbgde acbgfd abcde gfcbed gfec | fcgedb cgb dgebacf gc
  fgaebd cg bdaec gdafb agbcfd gdcbef bgcad gfac gcb cdgabef | cg cg fdcagb cbg
  fbegcd cbd adcefb dageb afcb bc aefdc ecdab fgdeca fcdbega | efabcd cedba gadfec cb
  aecbfdg fbg gf bafeg dbefa fcge gcbea fcaegb dgceab fcbdga | gecf egdcabf bgf bfgea
  fgeab ca afcebg bdacfeg cfaedg gcfdb baec bfadeg bafgc acf | gebdcfa ecba ca fadegcb
  dbcfg fgd bdegcaf fgec aegbdf ecdfab fbedc dacgb gdcebf gf | cefg dcbef fcge gbcadfe
  bdfegc cbegaf gecbf dfcage bdacg ed bedf ced adcbefg gebcd | ed bcgafe cdgba cbgef
  egadfb cdbfeg cegd fecab cgb gbdefca cg fgcdab egfdb bfceg | gbdfcae bgc cg cgb
  gcafb gcf dcaebfg ecagb gf abcdeg gaef cafbge fdbac fegbdc | fgae cfgab fg bagce
  ```

  Because the digits `1`, `4`, `7`, and `8` each use a unique number of
  segments, you should be able to tell which combinations of signals correspond
  to those digits. Counting only digits in the output values (the part after `|`
  on each line), in the above example, there are `26` instances of digits that
  use a unique number of segments (highlighted above).

  In the output values, how many times do digits `1`, `4`, `7`, or `8` appear?
  """
  @spec part_one(String.t()) :: integer()
  def part_one(input) do
    input
    |> parse_input()
    |> Enum.flat_map(&Map.get(&1, :output))
    |> Enum.map(fn x -> Map.get(@known_lengths, Enum.count(x)) end)
    |> Enum.filter(fn x -> x != nil end)
    |> Enum.count()
  end

  @doc """
  Through a little deduction, you should now be able to determine the remaining
  digits. Consider again the first example above:

  ```text
  acedgfb cdfbe gcdfa fbcad dab cefabd cdfgeb eafb cagedb ab | cdfeb fcadb cdfeb cdbaf
  ```

  After some careful analysis, the mapping between signal wires and segments
  only make sense in the following configuration:

  ```text
   dddd
  e    a
  e    a
   ffff
  g    b
  g    b
   cccc
  ```

  So, the unique signal patterns would correspond to the following digits:

  * `acedgfb`: `8`
  * `cdfbe`: `5`
  * `gcdfa`: `2`
  * `fbcad`: `3`
  * `dab`: `7`
  * `cefabd`: `9`
  * `cdfgeb`: `6`
  * `eafb`: `4`
  * `cagedb`: `0`
  * `ab`: `1`

  Then, the four digits of the output value can be decoded:

  * `cdfeb`: `5`
  * `fcadb`: `3`
  * `cdfeb`: `5`
  * `cdbaf`: `3`

  Therefore, the output value for this entry is `5353`.

  Following this same process for each entry in the second, larger example
  above, the output value of each entry can be determined:

  * `fdgacbe cefdb cefbgd gcbe`: `8394`
  * `fcgedb cgb dgebacf gc`: `9781`
  * `cg cg fdcagb cbg`: `1197`
  * `efabcd cedba gadfec cb`: `9361`
  * `gecf egdcabf bgf bfgea`: `4873`
  * `gebdcfa ecba ca fadegcb`: `8418`
  * `cefg dcbef fcge gbcadfe`: `4548`
  * `ed bcgafe cdgba cbgef`: `1625`
  * `gbdfcae bgc cg cgb`: `8717`
  * `fgae cfgab fg bagce`: `4315`

  Adding all of the output values in this larger example produces `61229`.

  For each entry, determine all of the wire/segment connections and decode the
  four-digit output values. What do you get if you add up all of the output
  values?
  """
  @spec part_two(String.t()) :: integer()
  def part_two(input) do
    input
    |> parse_input()
    |> Enum.map(&translate_output/1)
    |> Enum.sum()
  end

  @spec parse_input(String.t()) :: list(parsed_line_t())
  defp parse_input(raw) do
    raw
    |> String.split("\n", trim: true)
    |> Enum.map(&parse_signal_line/1)
  end

  @spec parse_signal_line(String.t()) :: parsed_line_t()
  defp parse_signal_line(line) do
    [signals, output] =
      line
      |> String.split(" | ", trim: true)
      |> Enum.map(&convert_tokens_to_sets/1)

    %{signals: signals, output: output}
  end

  @spec convert_tokens_to_sets(String.t()) :: list(signal_t())
  defp convert_tokens_to_sets(string) do
    string
    |> String.split(" ", trim: true)
    |> Enum.map(&MapSet.new(String.graphemes(&1)))
  end

  @spec translate_output(parsed_line_t()) :: integer()
  defp translate_output(%{signals: signals, output: output}) do
    dictionary = build_dictionary(signals)

    output
    |> Enum.map_join(&Map.get(dictionary, &1, 0))
    |> String.to_integer()
  end

  @spec build_dictionary(list(signal_t())) :: translation_dictionary_t()
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

  @spec find_known_signals(list(signal_t())) :: %{
          1 => list(signal_t()),
          4 => list(signal_t()),
          7 => list(signal_t()),
          8 => list(signal_t())
        }
  defp find_known_signals(signals) do
    %{
      1 => find_signals_by_length(signals, 2),
      4 => find_signals_by_length(signals, 4),
      7 => find_signals_by_length(signals, 3),
      8 => find_signals_by_length(signals, 7)
    }
  end

  @spec find_signals_by_length(list(signal_t()), integer()) :: list(signal_t())
  defp find_signals_by_length(signals, length) do
    Enum.filter(signals, &(Enum.count(&1) == length))
  end

  @spec find_signal_that_is_superset_with_one_additional_segment(list(signal_t()), signal_t()) ::
          {signal_t(), String.t()}
  defp find_signal_that_is_superset_with_one_additional_segment(signals, subset) do
    [result] =
      signals
      |> Enum.filter(&MapSet.subset?(subset, &1))
      |> Enum.map(fn s -> {s, MapSet.difference(s, subset)} end)
      |> Enum.filter(fn {_, d} -> Enum.count(d) == 1 end)
      |> Enum.map(fn {s, d} -> {s, Enum.at(d, 0)} end)

    result
  end

  @spec find_seg_b(signal_t(), signal_t(), String.t()) :: String.t()
  defp find_seg_b(four, one, seg_d) do
    four
    |> MapSet.difference(one)
    |> MapSet.delete(seg_d)
    |> Enum.at(0)
  end

  @spec find_seg_e(signal_t(), signal_t(), String.t(), String.t()) :: String.t()
  defp find_seg_e(zero, seven, seg_b, seg_g) do
    zero
    |> MapSet.difference(seven)
    |> MapSet.delete(seg_b)
    |> MapSet.delete(seg_g)
    |> Enum.at(0)
  end

  @spec find_seg_c(signal_t(), signal_t(), String.t()) :: String.t()
  defp find_seg_c(eight, five, seg_e) do
    eight
    |> MapSet.difference(five)
    |> MapSet.delete(seg_e)
    |> Enum.at(0)
  end

  @spec find_five(list(signal_t()), signal_t(), signal_t(), signal_t(), String.t()) :: signal_t()
  defp find_five(signals, three, four, nine, seg_b) do
    [five] =
      Enum.filter(signals, fn s ->
        diff = MapSet.difference(s, three)
        diff == MapSet.new([seg_b]) && s != four && s != nine
      end)

    five
  end

  @spec find_nine_three_seg_g_seg_d(list(signal_t()), signal_t(), signal_t(), String.t()) :: %{
          nine: signal_t(),
          seg_g: String.t(),
          three: signal_t(),
          seg_d: String.t()
        }
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

  @spec find_zero_two_five_six(list(signal_t()), list(signal_t()), list(String.t())) :: %{
          zero: signal_t(),
          two: signal_t(),
          five: signal_t(),
          six: signal_t()
        }
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
