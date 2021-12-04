input =

Benchee.run(%{
  "day 1 part one" => fn -> Day01.part_one(File.read!("priv/01.txt")) end,
  "day 1 part two" => fn -> Day01.part_two(File.read!("priv/01.txt")) end,
  "day 2 part one" => fn -> Day02.part_one(File.read!("priv/02.txt")) end,
  "day 2 part two" => fn -> Day02.part_two(File.read!("priv/02.txt")) end,
  "day 3 part one" => fn -> Day03.part_one(File.read!("priv/03.txt")) end,
  "day 3 part two" => fn -> Day03.part_two(File.read!("priv/03.txt")) end,
  "day 4 part one" => fn -> Day04.part_one(File.read!("priv/04.txt")) end,
  "day 4 part two" => fn -> Day04.part_two(File.read!("priv/04.txt")) end
})
