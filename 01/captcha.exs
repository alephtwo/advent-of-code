numbers = "input.txt"
  |> File.read!
  |> String.trim
  |> String.split("", trim: true)

range = (-1 .. (Enum.count(numbers) - 1))
matches_next = fn n -> (Enum.at(numbers, n) == Enum.at(numbers, n + 1)) end
range
  |> Enum.filter(matches_next)
  |> Enum.map(fn x -> Enum.at(numbers, x) end)
  |> Enum.map(&Integer.parse/1)
  |> Enum.map(fn {x, _} -> x end)
  |> Enum.reduce(0, &Kernel.+/2)
  |> IO.puts
