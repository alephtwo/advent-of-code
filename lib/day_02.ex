defmodule Day02 do
  @input File.read!("priv/02.txt")

  def part_one do
    @input
    |> parse_input()
    |> List.replace_at(1, 12)
    |> List.replace_at(2, 2)
    |> run_program()
  end

  def part_two do
    input = parse_input(@input)
    # Brute force it
    range = 1..100
    {noun, verb} = Enum.flat_map(range, fn noun ->
      Enum.map(range, fn verb ->
        ran = input
              |> List.replace_at(1, noun)
              |> List.replace_at(2, verb)
              |> run_program()
        if Enum.at(ran, 0) == 19690720 do
          {noun, verb}
        end
      end)
    end)
    |> Enum.filter(fn x -> x != nil end)
    |> Enum.at(0)

    # Do the thing
    100 * noun + verb
  end

  # Handle string input by parsing it before running it
  def run_program(memory) when is_binary(memory) do
    memory |> parse_input() |> run_program()
  end

  # Run the program
  def run_program(memory, ic \\ 0) when is_list(memory) do
    case do_instruction(Enum.slice(memory, ic, 4), memory) do
      {:stop, memory} -> memory
      {:continue, memory} -> run_program(memory, ic + 4)
    end
  end

  # Perform the instruction
  def do_instruction([opcode, a, b, i], memory) do
    first = Enum.at(memory, a)
    second = Enum.at(memory, b)
    case opcode do
      1 -> {:continue, List.replace_at(memory, i, first + second)}
      2 -> {:continue, List.replace_at(memory, i, first * second)}
      99 -> {:stop, memory}
    end
  end
  # When we haven't matched anything, we should stop
  def do_instruction(_, memory) do
    {:stop, memory}
  end

  def parse_input(input) do
    input
    |> String.trim()
    |> String.split(",", trim: true)
    |> Enum.map(&String.to_integer(&1))
  end
end
