defmodule DaySix do
  @moduledoc """
  Advent of Code 2017 Day 6 solutions.
  """
  @external_resource "priv/06.txt"
  @input File.read! "priv/06.txt"
  @typep result_pair :: {number, number}

  def part_one, do: get_steps(detect_infinite_loop(test_data()))
  def part_two, do: get_size(detect_infinite_loop(test_data()))

  @spec get_steps(result_pair) :: number
  def get_steps({steps, _}), do: steps

  @spec get_size(result_pair) :: number
  def get_size({_, size}), do: size

  @spec detect_infinite_loop(list) :: result_pair
  def detect_infinite_loop(banks), do: step(banks)

  @spec step(list, list, number) :: result_pair
  def step(banks, seen \\ [], steps_taken \\ 1) do
    updated_banks = update_banks(banks)
    if Enum.any?(seen, fn x -> x == updated_banks end) do
      {_, prev_step} = seen
                       |> Enum.with_index
                       |> Enum.filter(fn {x, _} -> x == updated_banks end)
                       |> List.first
      {steps_taken, steps_taken - prev_step - 1}
    else
      step(updated_banks, Enum.concat(seen, [updated_banks]), steps_taken + 1)
    end
  end

  @spec update_banks(list) :: list
  def update_banks(banks) do
    spread_across_banks(banks, choose_next_bank(banks))
  end

  @spec choose_next_bank(list) :: {number, number}
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

    spread = 1
             |> List.duplicate(bank_value)
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

  @spec rotate_left(list, number) :: list
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
