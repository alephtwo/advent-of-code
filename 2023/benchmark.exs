files = %{
  1 => File.read!("priv/01.txt"),
  2 => File.read!("priv/02.txt"),
}

Benchee.run(%{
  # "day 1 part one" => fn -> AdventOfCode2023.Day01.part_one(Map.get(files, 1)) end,
  # "day 1 part two" => fn -> AdventOfCode2023.Day01.part_two(Map.get(files, 1)) end,
  "day 2 part one" => fn -> AdventOfCode2023.Day02.part_one(Map.get(files, 2)) end,
  "day 2 part two" => fn -> AdventOfCode2023.Day02.part_two(Map.get(files, 2)) end,
})
