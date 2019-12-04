defmodule Day04 do
  @input 273025..767253

  def part_one do
    @input
    |> Enum.map(&Integer.to_string/1)
    |> Enum.filter(&passes_criteria/1)
    |> Enum.count()
  end

  def passes_criteria(password) do
    repeated_digit = String.match?(password, ~r"(\d)\1+")
    {not_decreasing, _} =
      password
      |> String.split("", trim: true)
      |> Enum.reduce({true, 0}, fn x, {satisfied, last} ->
        {satisfied && x >= last, x}
      end)

    repeated_digit && not_decreasing
  end
end
