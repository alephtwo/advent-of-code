files = %{
  1 => File.read!("priv/01.txt"),
  2 => File.read!("priv/02.txt"),
  3 => File.read!("priv/03.txt"),
  4 => File.read!("priv/04.txt"),
  5 => File.read!("priv/05.txt"),
  6 => File.read!("priv/06.txt"),
  7 => File.read!("priv/07.txt"),
  8 => File.read!("priv/08.txt"),
  9 => File.read!("priv/09.txt"),
  10 => File.read!("priv/10.txt"),
  11 => File.read!("priv/11.txt"),
  12 => File.read!("priv/12.txt"),
  13 => File.read!("priv/13.txt"),
  14 => File.read!("priv/14.txt"),
}

Benchee.run(%{
  # "day 1 part one" => fn -> Day01.part_one(Map.get(files, 1)) end,
  # "day 1 part two" => fn -> Day01.part_two(Map.get(files, 1)) end,
  # "day 2 part one" => fn -> Day02.part_one(Map.get(files, 2)) end,
  # "day 2 part two" => fn -> Day02.part_two(Map.get(files, 2)) end,
  # "day 3 part one" => fn -> Day03.part_one(Map.get(files, 3)) end,
  # "day 3 part two" => fn -> Day03.part_two(Map.get(files, 3)) end,
  # "day 4 part one" => fn -> Day04.part_one(Map.get(files, 4)) end,
  # "day 4 part two" => fn -> Day04.part_two(Map.get(files, 4)) end,
  # "day 5 part one" => fn -> Day05.part_one(Map.get(files, 5)) end,
  # "day 5 part two" => fn -> Day05.part_two(Map.get(files, 5)) end,
  # "day 6 part one" => fn -> Day06.part_one(Map.get(files, 6)) end,
  # "day 6 part two" => fn -> Day06.part_two(Map.get(files, 6)) end,
  # "day 7 part one" => fn -> Day07.part_one(Map.get(files, 7)) end,
  # "day 7 part two" => fn -> Day07.part_two(Map.get(files, 7)) end,
  # "day 8 part one" => fn -> Day08.part_one(Map.get(files, 8)) end,
  # "day 8 part two" => fn -> Day08.part_two(Map.get(files, 8)) end,
  # "day 9 part one" => fn -> Day09.part_one(Map.get(files, 9)) end,
  # "day 9 part two" => fn -> Day09.part_two(Map.get(files, 9)) end,
  # "day 10 part one" => fn -> Day10.part_one(Map.get(files, 10)) end,
  # "day 10 part two" => fn -> Day10.part_two(Map.get(files, 10)) end,
  # "day 11 part one" => fn -> Day11.part_one(Map.get(files, 11)) end,
  # "day 11 part two" => fn -> Day11.part_two(Map.get(files, 11)) end,
  # "day 12 part one" => fn -> Day12.part_one(Map.get(files, 12)) end,
  # "day 12 part two" => fn -> Day12.part_two(Map.get(files, 12)) end,
  # "day 13 part one" => fn -> Day13.part_one(Map.get(files, 13)) end,
  # "day 13 part two" => fn -> Day13.part_two(Map.get(files, 13)) end,
  "day 14 part one" => fn -> Day14.part_one(Map.get(files, 14)) end,
  "day 14 part two" => fn -> Day14.part_two(Map.get(files, 14)) end,
})
