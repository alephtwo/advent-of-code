defmodule Day08 do
  @moduledoc """
  Day 8 of Advent of Code 2020.
  """
  @input File.read!("priv/08.txt")

  def part_one(input \\ @input) do
    {:break, final_state} =
      input
      |> parse_input()
      |> run_program()

    final_state.accumulator
  end

  def part_two(input \\ @input), do: input

  defp run_program(program) do
    # Start doing some stuff.
    resolve_state(%{
      program: program,
      accumulator: 0,
      pc: 0,
      executed: MapSet.new()
    })
  end

  defp resolve_state(state) do
    cond do
      # Detect infinite loops
      MapSet.member?(state.executed, state.pc) ->
        {:break, state}

      # Finish if we're done!
      state.pc > Enum.count(state.program) ->
        {:complete, state}

      # Otherwise, step and recurse
      true ->
        instruction = Enum.at(state.program, state.pc)

        base_next_state =
          Map.merge(state, %{
            executed: MapSet.put(state.executed, state.pc)
          })

        next_state =
          case Enum.at(state.program, state.pc).operation do
            "acc" ->
              base_next_state
              |> Map.update!(:accumulator, fn acc -> acc + instruction.argument end)
              |> Map.update!(:pc, fn pc -> pc + 1 end)

            "jmp" ->
              Map.update!(base_next_state, :pc, fn pc -> pc + instruction.argument end)

            "nop" ->
              Map.update!(base_next_state, :pc, fn pc -> pc + 1 end)
          end

        # Recurse!
        resolve_state(next_state)
    end
  end

  defp parse_input(input) do
    input
    |> String.split("\n", trim: true)
    |> Enum.map(&parse_instruction/1)
  end

  defp parse_instruction(instruction) do
    [operation, argument] = String.split(instruction, " ", trim: true)
    %{operation: operation, argument: String.to_integer(argument)}
  end
end
