defmodule Day02 do
  @input File.read!("priv/02.txt")

  def part_one do
    @input
    |> parse_input()
    |> List.replace_at(1, 12)
    |> List.replace_at(2, 2)
    |> IntcodeComputer.run_program()
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
              |> IntcodeComputer.run_program()
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

  def parse_input(input) do
    input
    |> String.trim()
    |> String.split(",", trim: true)
    |> Enum.map(&String.to_integer(&1))
  end
end
