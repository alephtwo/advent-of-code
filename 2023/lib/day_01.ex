defmodule AdventOfCode2023.Day01 do
  @moduledoc """
  Day 1: Trebuchet?!
  """

  @doc """
  Something is wrong with global snow production, and you've been selected to
  take a look. The Elves have even given you a map; on it, they've used stars to
  mark the top fifty locations that are likely to be having problems.

  You've been doing this long enough to know that to restore snow operations,
  you need to check all fifty stars by December 25th.

  Collect stars by solving puzzles. Two puzzles will be made available on each
  day in the Advent calendar; the second puzzle is unlocked when you complete
  the first. Each puzzle grants one star. Good luck!

  You try to ask why they can't just use a weather machine ("not powerful
  enough") and where they're even sending you ("the sky") and why your map looks
  mostly blank ("you sure ask a lot of questions") and hang on did you just say
  the sky ("of course, where do you think snow comes from") when you realize
  that the Elves are already loading you into a trebuchet ("please hold still,
  we need to strap you in").

  As they're making the final adjustments, they discover that their calibration
  document (your puzzle input) has been amended by a very young Elf who was
  apparently just excited to show off her art skills. Consequently, the Elves
  are having trouble reading the values on the document.

  The newly-improved calibration document consists of lines of text; each line
  originally contained a specific calibration value that the Elves now need to
  recover. On each line, the calibration value can be found by combining the
  first digit and the last digit (in that order) to form a single two-digit
  number.

  For example:

  ```
  1abc2
  pqr3stu8vwx
  a1b2c3d4e5f
  treb7uchet
  ```

  In this example, the calibration values of these four lines are `12`, `38`,
  `15`, and `77`. Adding these together produces `142`.

  Consider your entire calibration document. What is the sum of all of the
  calibration values?
  """
  def part_one(input) do
    input
    |> parse_input()
    |> Enum.map(&scan_digits/1)
    |> Enum.map(&find_calibration_value/1)
    |> Enum.sum()
  end

  @doc """
  Your calculation isn't quite right. It looks like some of the digits are
  actually spelled out with letters: `one`, `two`, `three`, `four`, `five`,
  `six`, `seven`, `eight`, and `nine` also count as valid "digits".

  Equipped with this new information, you now need to find the real first and
  last digit on each line. For example:

  ```
  two1nine
  eightwothree
  abcone2threexyz
  xtwone3four
  4nineeightseven2
  zoneight234
  7pqrstsixteen
  ```

  In this example, the calibration values are `29`, `83`, `13`, `24`, `42`,
  `14`, and `76`. Adding these together produces `281`.

  What is the sum of all of the calibration values?
  """
  def part_two(input) do
    input
    |> parse_input()
    |> Enum.map(&scan_numbers/1)
    |> Enum.map(&find_calibration_value/1)
    |> Enum.sum()
  end

  defp parse_input(input) do
    input
    |> String.split("\n", trim: true)
  end

  defp scan_digits(line) do
    line
    |> String.graphemes()
    |> Enum.map(&Integer.parse/1)
    |> Enum.filter(fn x -> x != :error end)
    |> Enum.map(fn {x, _} -> x end)
  end

  # If there is a god, I pray I will be forgiven for this sin I have committed.
  # but, quite frankly, it works just fine and is pretty fast all things
  # considered. Sue me.
  #
  # credo:disable-for-next-line
  defp scan_numbers(line) do
    %{numbers: numbers} =
      line
      |> String.graphemes()
      |> Enum.reduce(%{string: "", numbers: []}, fn c, acc ->
        seen = acc.string <> c
        attempt = Integer.parse(c)

        %{
          string: seen,
          numbers:
            cond do
              attempt != :error -> [elem(attempt, 0) | acc.numbers]
              String.ends_with?(seen, "one") -> [1 | acc.numbers]
              String.ends_with?(seen, "two") -> [2 | acc.numbers]
              String.ends_with?(seen, "three") -> [3 | acc.numbers]
              String.ends_with?(seen, "four") -> [4 | acc.numbers]
              String.ends_with?(seen, "five") -> [5 | acc.numbers]
              String.ends_with?(seen, "six") -> [6 | acc.numbers]
              String.ends_with?(seen, "seven") -> [7 | acc.numbers]
              String.ends_with?(seen, "eight") -> [8 | acc.numbers]
              String.ends_with?(seen, "nine") -> [9 | acc.numbers]
              true -> acc.numbers
            end
        }
      end)

    Enum.reverse(numbers)
  end

  defp find_calibration_value(numbers) do
    List.first(numbers) * 10 + List.last(numbers)
  end
end
