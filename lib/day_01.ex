defmodule Day01 do
  @input File.read!("priv/01.txt")
         |> String.split("\n", trim: true)
         |> Enum.map(&String.to_integer(&1))

  def part_one do
    @input
    |> Enum.map(&calculate_fuel_from_mass(&1))
    |> Enum.sum()
  end

  def calculate_fuel_from_mass(mass), do: div(mass, 3) - 2
end
