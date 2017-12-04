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
find_pair = fn row, {element, index} ->
  row
  |> Enum.with_index
  |> Enum.filter(fn {_, i} -> i != index end)
  |> Enum.map(fn {e, _} -> [element, e] end)
  |> Enum.filter(fn [a, b] -> rem(a, b) == 0 end)
  |> List.flatten
end

pairify = fn row ->
  row
  |> Enum.with_index
  |> Enum.map(fn i -> find_pair.(row, i) end)
  |> Enum.filter(&Enum.any?/1)
  |> List.flatten
end

input
|> Enum.map(&Enum.sort/1)
|> Enum.map(&Enum.reverse/1)
|> Enum.map(pairify)
|> Enum.map(fn [a, b] -> div(a, b) end)
|> Enum.sum
|> IO.inspect
