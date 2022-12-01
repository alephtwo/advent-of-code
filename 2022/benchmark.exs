files = %{
  1 => File.read!("priv/01.txt")
}

Benchee.run(%{
  "day 1 part one" => fn -> Day01.part_one(Map.get(files, 1)) end,
  "day 1 part two" => fn -> Day01.part_two(Map.get(files, 1)) end,
})
