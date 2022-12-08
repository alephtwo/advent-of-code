files = %{
  1 => File.read!("priv/01.txt"),
  2 => File.read!("priv/02.txt"),
  3 => File.read!("priv/03.txt"),
  4 => File.read!("priv/04.txt"),
  5 => File.read!("priv/05.txt"),
  6 => File.read!("priv/06.txt"),
  7 => File.read!("priv/07.txt"),
  8 => File.read!("priv/08.txt"),
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
  "day 8 part one" => fn -> Day08.part_one(Map.get(files, 8)) end,
  "day 8 part two" => fn -> Day08.part_two(Map.get(files, 8)) end,
})
