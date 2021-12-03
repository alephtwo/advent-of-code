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

  def part_two(input \\ @input) do
    program = parse_input(input)

    indices_to_replace =
      program
      |> Enum.with_index()
      |> Enum.filter(fn {i, _} -> i.operation == "jmp" || i.operation == "nop" end)
      |> Enum.map(fn {_, i} -> i end)

    # Loop over all of the indexes we want to replace and swap out just one at a time.
    # Get a list of all the programs that result from this.
    programs = Enum.map(indices_to_replace, fn i -> get_edited_program(i, program) end)

    # Run each program to see if it finishes.
    # Find the one that does and deal with it.
    {:complete, working_program} =
      Enum.map(programs, fn program -> run_program(program) end)
      |> Enum.filter(fn {completed, _} -> completed == :complete end)
      |> Enum.at(0)

    working_program.accumulator
  end

  defp run_program(program) do
    # Start doing some stuff.
    resolve_state(%{
      program: program,
      accumulator: 0,
      pc: 0,
      executed: MapSet.new()
    })
  end

  defp get_edited_program(index, program) do
    edited_instruction =
      Map.update!(Enum.at(program, index), :operation, fn o ->
        case o do
          "jmp" -> "nop"
          "nop" -> "jmp"
        end
      end)

    List.replace_at(program, index, edited_instruction)
  end

  defp resolve_state(state) do
    instruction = Enum.at(state.program, state.pc)

    cond do
      # Detect infinite loops
      MapSet.member?(state.executed, state.pc) ->
        {:break, state}

      # Finish if we're done!
      state.pc > Enum.count(state.program) ->
        {:complete, state}

      instruction == nil ->
        {:complete, state}

      # Otherwise, step and recurse
      true ->
        base_next_state =
          Map.merge(state, %{
            executed: MapSet.put(state.executed, state.pc)
          })

        next_state =
          case instruction.operation do
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
