defmodule AdventOfCode2023.Day05 do
  @moduledoc """
  """

  defmodule Almanac do
    defstruct seeds: [],
              seed_to_soil: nil,
              soil_to_fertilizer: nil,
              fertilizer_to_water: nil,
              water_to_light: nil,
              light_to_temperature: nil,
              temperature_to_humidity: nil,
              humidity_to_location: nil
  end

  @doc """
  """
  def part_one(input) do
    input
    |> parse_input()
  end

  @doc """
  """
  def part_two(input) do
    input
    |> parse_input()
  end

  defp parse_input(input) do
    [
      seeds,
      seed_to_soil,
      soil_to_fertilizer,
      fertilizer_to_water,
      water_to_light,
      light_to_temperature,
      temperature_to_humidity,
      humidity_to_location
    ] = String.split(input, "\n\n", trim: true)

    %Almanac{
      seeds:
        seeds
        |> String.replace_prefix("seeds: ", "")
        |> parse_space_separated_numbers(),
      seed_to_soil: parse_almanac_ranges(seed_to_soil),
      soil_to_fertilizer: parse_almanac_ranges(soil_to_fertilizer),
      fertilizer_to_water: parse_almanac_ranges(fertilizer_to_water),
      water_to_light: parse_almanac_ranges(water_to_light),
      light_to_temperature: parse_almanac_ranges(light_to_temperature),
      temperature_to_humidity: parse_almanac_ranges(temperature_to_humidity),
      humidity_to_location: parse_almanac_ranges(humidity_to_location)
    }
  end

  defp parse_almanac_ranges(mapstring) do
    # throw away the first line, it's just a header
    [_ | ranges] = String.split(mapstring, "\n", trim: true)

    ranges
    |> Enum.map(&parse_space_separated_numbers/1)
    # take for granted that there are exactly three numbers in each row
    |> Enum.map(fn [dest_start, source_start, range_length] ->
      0..(range_length - 1)
      |> Enum.map(fn i -> {source_start + i, dest_start + i} end)
    end)
    |> Enum.reduce(%{}, fn a, acc -> Map.merge(acc, Map.new(a)) end)
  end

  defp parse_space_separated_numbers(input) do
    input
    |> String.split(" ", trim: true)
    |> Enum.map(&Integer.parse/1)
    |> Enum.map(&elem(&1, 0))
  end
end
