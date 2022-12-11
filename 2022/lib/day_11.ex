defmodule Day11 do
  @moduledoc """
  Day 11 of Advent of Code 2022.
  """

  defmodule Monkey do
    defstruct [:number, :items, :operation, :divisor, :if_true, :if_false, items_inspected: 0]
  end

  @monkey_regex ~r/^Monkey (\d+):$/
  @starting_items_regex ~r/^  Starting items: (.*)$/
  @operation_regex ~r/^  Operation: new = old (.*)$/
  @divisor_regex ~r/^  Test: divisible by (\d+)$/
  @if_true_regex ~r/^    If true: throw to monkey (\d+)$/
  @if_false_regex ~r/^    If false: throw to monkey (\d+)$/

  @doc """
  """
  @spec part_one(String.t()) :: number()
  def part_one(input) do
    monkeys = parse_input(input)

    # rounds
    1..20
    |> Enum.reduce(%{monkeys: monkeys, calm_down: true, mod: nil}, &execute_round/2)
    |> then(fn %{monkeys: monkeys, calm_down: _} -> monkeys end)
    |> Map.values()
    |> Enum.map(fn %Monkey{items_inspected: i} -> i end)
    |> Enum.sort()
    |> Enum.reverse()
    |> Enum.take(2)
    |> Enum.product()
  end

  @doc """
  """
  @spec part_two(String.t()) :: number()
  def part_two(input) do
    monkeys = parse_input(input)

    mod =
      monkeys
      |> Map.values()
      |> Enum.map(fn m -> m.divisor end)
      # lcm of distinct primes is its product
      |> Enum.product()

    # rounds
    1..10_000
    |> Enum.reduce(%{monkeys: monkeys, calm_down: false, mod: mod}, &execute_round/2)
    |> then(fn %{monkeys: monkeys, calm_down: _} -> monkeys end)
    |> Map.values()
    |> Enum.map(fn %Monkey{items_inspected: i} -> i end)
    |> Enum.sort()
    |> Enum.reverse()
    |> Enum.take(2)
    |> Enum.product()
  end

  defp execute_round(_round, state = %{monkeys: monkeys, calm_down: _, mod: _}) do
    # each monkey takes a turn
    monkeys
    |> Map.keys()
    |> Enum.reduce(state, &take_monkey_turn/2)
  end

  defp take_monkey_turn(number, state = %{monkeys: monkeys, calm_down: calm_down, mod: mod}) do
    # we need to grab the monkey out of the state so that it is up to date
    # with the latest information
    monkey = Map.get(monkeys, number)

    # the monkey inspects its items
    new_monkeys =
      monkey.items
      # we probably don't need to pass the monkey as context but it will
      # make lookups and operations much faster if we don't have to search
      # for the monkey with the particular item
      |> Enum.reduce(
        %{monkey: monkey, monkeys: monkeys, calm_down: calm_down, mod: mod},
        &inspect_item/2
      )
      # we can throw the monkey away as it was just context
      |> then(fn %{monkey: _, monkeys: monkeys} -> monkeys end)

    %{state | monkeys: new_monkeys}
  end

  defp inspect_item(
         item,
         state = %{monkey: monkey, monkeys: monkeys, calm_down: calm_down, mod: mod}
       ) do
    worry =
      if calm_down do
        item |> monkey.operation.() |> div(3)
      else
        monkey.operation.(item) |> rem(mod)
      end

    # where next?
    next_monkey = if rem(worry, monkey.divisor) == 0, do: monkey.if_true, else: monkey.if_false

    new_monkeys =
      monkeys
      # take the item out of the current monkey's queue
      |> Map.update!(monkey.number, fn m ->
        %Monkey{m | items: Enum.drop(m.items, 1), items_inspected: m.items_inspected + 1}
      end)
      |> Map.update!(next_monkey, fn m ->
        %Monkey{m | items: Enum.reverse([worry | Enum.reverse(m.items)])}
      end)

    %{state | monkeys: new_monkeys}
  end

  defp parse_input(input) do
    input
    |> String.split("\n\n", trim: true)
    |> Enum.map(&parse_monkey/1)
    |> Map.new()
  end

  defp parse_monkey(monkey) do
    lines = String.split(monkey, "\n", trim: true)

    number =
      @monkey_regex
      |> Regex.run(Enum.at(lines, 0))
      |> then(fn [_, number] -> String.to_integer(number) end)

    starting_items =
      @starting_items_regex
      |> Regex.run(Enum.at(lines, 1))
      |> then(fn [_, items] -> items end)
      |> String.split(", ", trim: true)
      |> Enum.map(&String.to_integer/1)

    operation =
      @operation_regex
      |> Regex.run(Enum.at(lines, 2))
      |> then(fn [_, op] -> op end)
      |> String.split(" ")
      |> parse_operation()

    divisor =
      @divisor_regex
      |> Regex.run(Enum.at(lines, 3))
      |> then(fn [_, divisor] -> divisor end)
      |> String.to_integer()

    if_true =
      @if_true_regex
      |> Regex.run(Enum.at(lines, 4))
      |> then(fn [_, monkey] -> String.to_integer(monkey) end)

    if_false =
      @if_false_regex
      |> Regex.run(Enum.at(lines, 5))
      |> then(fn [_, monkey] -> String.to_integer(monkey) end)

    {number,
     %Monkey{
       number: number,
       items: starting_items,
       operation: operation,
       divisor: divisor,
       if_true: if_true,
       if_false: if_false
     }}
  end

  defp parse_operation(["+", "old"]), do: fn old -> old + old end
  defp parse_operation(["*", "old"]), do: fn old -> old * old end
  defp parse_operation(["+", x]), do: fn old -> old + String.to_integer(x) end
  defp parse_operation(["*", x]), do: fn old -> old * String.to_integer(x) end
end
