defmodule Day04 do
  @input 273025..767253 |> Enum.map(&Integer.to_string/1)

  def part_one do
    @input
    |> Enum.filter(&passes_criteria/1)
    |> Enum.count()
  end

  def part_two do
    @input
    |> Enum.filter(&passes_strict_criteria/1)
    |> Enum.count()
  end

  def passes_criteria(password) do
    not_decreasing(password) && contains_repeated_digits(password)
  end

  def passes_strict_criteria(password) do
    not_decreasing(password) && contains_digit_pair(password)
  end

  defp contains_repeated_digits(password) do
    String.match?(password, ~r"(\d)\1+")
  end

  defp contains_digit_pair(password) do
    no_large_groups = Regex.replace(~r"(\d)\1{2,6}", password, "")
    contains_repeated_digits(no_large_groups)
  end

  defp not_decreasing(password) do
    {not_decreasing, _} =
      password
      |> String.split("", trim: true)
      |> Enum.reduce({true, 0}, fn x, {satisfied, last} ->
        {satisfied && x >= last, x}
      end)
    not_decreasing
  end
end
