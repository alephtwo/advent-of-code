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

  defmodule AlmanacMapping do
    defstruct start: nil, end: nil, offset: nil
  end

  @doc """
  """
  def part_one(input) do
    almanac = parse_input(input)

    almanac.seeds
    |> Enum.map(fn seed -> map_source_to_dest(seed, almanac.seed_to_soil) end)
    |> Enum.map(fn soil -> map_source_to_dest(soil, almanac.soil_to_fertilizer) end)
    |> Enum.map(fn fertilizer -> map_source_to_dest(fertilizer, almanac.fertilizer_to_water) end)
    |> Enum.map(fn water -> map_source_to_dest(water, almanac.water_to_light) end)
    |> Enum.map(fn light -> map_source_to_dest(light, almanac.light_to_temperature) end)
    |> Enum.map(fn temp -> map_source_to_dest(temp, almanac.temperature_to_humidity) end)
    |> Enum.map(fn humidity -> map_source_to_dest(humidity, almanac.humidity_to_location) end)
    |> Enum.min()
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
      %AlmanacMapping{
        start: source_start,
        end: source_start + (range_length - 1),
        offset: dest_start - source_start
      }
    end)
  end

  defp map_source_to_dest(source, mappings) do
    case Enum.find(mappings, fn m -> m.start <= source && m.end >= source end) do
      nil ->
        source

      mapping ->
        source + mapping.offset
    end
  end

  defp parse_space_separated_numbers(input) do
    input
    |> String.split(" ", trim: true)
    |> Enum.map(&Integer.parse/1)
    |> Enum.map(&elem(&1, 0))
  end
end
