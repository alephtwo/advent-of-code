Benchee.run(%{
  "day 1 part one" => fn -> Day01.part_one(File.read!("priv/01.txt")) end,
  "day 1 part two" => fn -> Day01.part_two(File.read!("priv/01.txt")) end,
})
