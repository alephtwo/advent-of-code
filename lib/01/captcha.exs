numbers = "input.txt"
  |> File.read!
  |> String.trim
  |> String.split("", trim: true)
  |> Enum.map(&Integer.parse/1)
  |> Enum.map(fn {x, _} -> x end)

count = Enum.count(numbers)
halfway_around = div(count, 2)
range = (-count .. -1)

print_captcha = fn filter ->
  range
    |> Enum.filter(filter)
    |> Enum.map(fn x -> Enum.at(numbers, x) end)
    |> Enum.reduce(0, &Kernel.+/2)
    |> IO.puts
end

matches_next = fn n -> (Enum.at(numbers, n) == Enum.at(numbers, n + 1)) end
print_captcha.(matches_next)

matches_halfway_around = fn n ->
  Enum.at(numbers, n) == Enum.at(numbers, n + halfway_around)
end
print_captcha.(matches_halfway_around)
