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
    almanac = parse_input(input, fn seeds -> seeds |> parse_space_separated_numbers() end)

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
    almanac =
      parse_input(input, fn seeds ->
        seeds
        |> parse_space_separated_numbers()
        |> Enum.chunk_every(2)
        |> Enum.map(fn [a, r] -> {a, a + r - 1} end)
      end)

    find_lowest_location_with_seed(almanac)
  end

  defp find_lowest_location_with_seed(almanac = %Almanac{}, location \\ 0) do
    seed =
      location
      |> map_dest_to_source(almanac.humidity_to_location)
      |> map_dest_to_source(almanac.temperature_to_humidity)
      |> map_dest_to_source(almanac.light_to_temperature)
      |> map_dest_to_source(almanac.water_to_light)
      |> map_dest_to_source(almanac.fertilizer_to_water)
      |> map_dest_to_source(almanac.soil_to_fertilizer)
      |> map_dest_to_source(almanac.seed_to_soil)

    if Enum.any?(almanac.seeds, fn {s, e} -> seed >= s && seed <= e end) do
      location
    else
      find_lowest_location_with_seed(almanac, location + 1)
    end
  end

  defp parse_input(input, seed_parser) do
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
      seeds: seed_parser.(String.replace_prefix(seeds, "seeds: ", "")),
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

  defp map_dest_to_source(dest, mappings) do
    case Enum.find(mappings, fn m -> dest >= m.start + m.offset && dest <= m.end + m.offset end) do
      nil ->
        dest

      mapping ->
        dest - mapping.offset
    end
  end

  defp parse_space_separated_numbers(input) do
    input
    |> String.split(" ", trim: true)
    |> Enum.map(&Integer.parse/1)
    |> Enum.map(&elem(&1, 0))
  end
end
