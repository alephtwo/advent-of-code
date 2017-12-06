defmodule DaySix do
  @external_resource "priv/06.txt"
  @input File.read! "priv/06.txt"

  def part_one, do: steps_to_detect_infinite_loop(test_data())

  def steps_to_detect_infinite_loop(banks) do
    next_bank = choose_next_bank(banks)
    banks_after_spread = spread_across_banks(banks, next_bank)
  end

  def choose_next_bank(banks) do
    max_value = Enum.max(banks, fn {v, _} -> v end)
    banks
    |> Enum.with_index
    |> Enum.filter(fn {v, _} -> v == max_value end)
    |> Enum.min(fn {_, i} -> i end)
  end

  def spread_across_banks(banks, {bank_value, bank_index}) do
    banks_after_removal = List.replace_at(banks, bank_index, 0)
    bank_count = Enum.count(banks)
    chunk_size = round(:math.ceil(bank_value / bank_count))
    spread = List.duplicate(1, bank_value)
             |> Enum.chunk_every(chunk_size)
             |> Enum.map(&Enum.sum/1)
             |> rotate_left((bank_count - bank_index - 1))

    IO.inspect(spread)
  end

  def rotate_left(list, 0), do: list
  def rotate_left(list, offset) when offset < 0 do
    rotate_left(list, Enum.count(list) - abs(offset))
  end
  def rotate_left(list, offset) do
    {popped, list_after_pop} = List.pop_at(list, 0)
    list_after_pop
    |> List.insert_at(Enum.count(list_after_pop), popped)
    |> rotate_left(offset - 1)
  end


  defp test_data, do: @input |> String.trim |> String.split("\t", trim: true)
end
