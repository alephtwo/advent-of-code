files = %{
  1 => File.read!("priv/01.txt"),
  2 => File.read!("priv/02.txt"),
  3 => File.read!("priv/03.txt"),
  4 => File.read!("priv/04.txt"),
}

Benchee.run(%{
  # "day 1 part one" => fn -> AdventOfCode2023.Day01.part_one(Map.get(files, 1)) end,
  # "day 1 part two" => fn -> AdventOfCode2023.Day01.part_two(Map.get(files, 1)) end,
  # "day 2 part one" => fn -> AdventOfCode2023.Day02.part_one(Map.get(files, 2)) end,
  # "day 2 part two" => fn -> AdventOfCode2023.Day02.part_two(Map.get(files, 2)) end,
  # "day 3 part one" => fn -> AdventOfCode2023.Day03.part_one(Map.get(files, 3)) end,
  # "day 3 part two" => fn -> AdventOfCode2023.Day03.part_two(Map.get(files, 3)) end,
  "day 4 part one" => fn -> AdventOfCode2023.Day04.part_one(Map.get(files, 4)) end,
  "day 4 part two" => fn -> AdventOfCode2023.Day04.part_two(Map.get(files, 4)) end,
})
