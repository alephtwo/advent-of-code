defmodule DaySix do
  @external_resource "priv/06.txt"
  @input File.read! "priv/06.txt"

  def part_one, do: steps_to_detect_infinite_loop(test_data())

  def steps_to_detect_infinite_loop(banks), do: step(banks, MapSet.new())

  def step(banks, seen, steps_taken \\ 1) do
    updated_banks = update_banks(banks)
    if  Enum.any?(seen, fn x -> x == updated_banks end) do
      steps_taken
    else
      step(updated_banks, MapSet.put(seen, updated_banks), steps_taken + 1)
    end
  end

  def update_banks(banks) do
    spread_across_banks(banks, choose_next_bank(banks))
  end

  def choose_next_bank(banks) do
    max_value = Enum.max(banks, fn {v, _} -> v end)
    banks
    |> Enum.with_index
    |> Enum.filter(fn {v, _} -> v == max_value end)
    |> Enum.min(fn {_, i} -> i end)
  end

  defp spread_across_banks(banks, {bank_value, bank_index}) do
    banks_after_removal = List.replace_at(banks, bank_index, 0)
    bank_count = Enum.count(banks)
    chunk_size = round(:math.ceil(bank_value / bank_count))

    spread = List.duplicate(1, bank_value)
             |> Enum.chunk_every(chunk_size)
             |> Enum.map(&Enum.sum/1)

    spreads_needed = bank_count - Enum.count(spread)
    fixed_spread =
      spread
      |> Enum.concat(List.duplicate(0, Enum.max([spreads_needed, 0])))

    rotation = bank_count - bank_index - 1
    [banks_after_removal, fixed_spread |> rotate_left(rotation)]
    |> List.zip
    |> Enum.map(fn {a, b} -> a + b end)
  end

  def rotate_left(list, 0), do: list
  def rotate_left(list, offset) when offset < 0 do
    rotate_left(list, Enum.count(list) - abs(offset))
  end
  def rotate_left(list, offset) do
    {popped, list_after_pop} = List.pop_at(list, 0)
    list_after_pop
    |> Enum.concat([popped])
    |> rotate_left(offset - 1)
  end

  defp test_data do
    @input
    |> String.trim
    |> String.split("\t", trim: true)
    |> Enum.map(&String.to_integer/1)
  end
end
