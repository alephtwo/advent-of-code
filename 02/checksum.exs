split_and_parse = fn str ->
  str
  |> String.split("\t", trim: true)
  |> Enum.map(&String.to_integer/1)
end

input = "input.txt"
        |> File.read!
        |> String.split("\n", trim: true)
        |> Enum.map(split_and_parse)

# Part One
input
|> Enum.map(fn row -> Enum.max(row) - Enum.min(row) end)
|> Enum.sum
|> IO.puts

# Part Two
input
|> IO.inspect
