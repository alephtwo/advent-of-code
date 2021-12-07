input =

Benchee.run(%{
  "day 1 part one" => fn -> Day01.part_one(File.read!("priv/01.txt")) end,
  "day 1 part two" => fn -> Day01.part_two(File.read!("priv/01.txt")) end,
  "day 2 part one" => fn -> Day02.part_one(File.read!("priv/02.txt")) end,
  "day 2 part two" => fn -> Day02.part_two(File.read!("priv/02.txt")) end,
  "day 3 part one" => fn -> Day03.part_one(File.read!("priv/03.txt")) end,
  "day 3 part two" => fn -> Day03.part_two(File.read!("priv/03.txt")) end,
  "day 4 part one" => fn -> Day04.part_one(File.read!("priv/04.txt")) end,
  "day 4 part one" => fn -> Day04.part_one(File.read!("priv/04.txt")) end,
  "day 5 part one" => fn -> Day05.part_one(File.read!("priv/05.txt")) end,
  "day 5 part two" => fn -> Day05.part_two(File.read!("priv/05.txt")) end,
  "day 6 part one" => fn -> Day06.part_one(File.read!("priv/06.txt")) end,
  "day 6 part two" => fn -> Day06.part_two(File.read!("priv/06.txt")) end,
  "day 7 part one" => fn -> Day07.part_one(File.read!("priv/07.txt")) end,
  "day 7 part two" => fn -> Day07.part_two(File.read!("priv/07.txt")) end
})
