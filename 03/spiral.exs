# Need to make the ulam spiral.
defmodule SpiralMemory do
  require Integer

  def dist_to_core(1), do: 0
  def dist_to_core(n) do
    on_a_side = side_length(trunc(:math.sqrt(n)), n)
    div((on_a_side - 1), 2) + steps_to_middle(n, on_a_side)
  end

  defp side_length(sqrt, _) when Integer.is_even(sqrt), do: sqrt + 1
  defp side_length(sqrt, n) when sqrt * sqrt == n, do: sqrt
  defp side_length(sqrt, _), do: sqrt + 2

  defp steps_to_middle(n, on_a_side) do
    corners = get_corners(round(:math.pow(on_a_side, 2)), on_a_side - 1)
    {closest_distance, _} = find_closest_corner(n, corners)
    closest_distance
  end

  defp get_corners(sqrt_corner, side_length) do
    to_middle = div(side_length, 2)
    0..3 |> Enum.map(fn x -> sqrt_corner - to_middle - x * side_length end)
  end

  defp find_closest_corner(number, corners) do
    corners
    |> Enum.map(fn x -> {abs(x - number), x} end)
    |> Enum.min
  end
end

defmodule SpiralMemory2 do
  def solve(n) do
    start_walking(%{{0, 0} => 1}, {0, 0}, 2, n)
  end

  defp start_walking(map, prev, steps, number) do
    {new_map, current, value} =
      {map, prev, 1} |> walk(1, {1, 0}, number)
                          |> walk(steps-1, {0, 1}, number)
                          |> walk(steps, {-1, 0}, number)
                          |> walk(steps, {0, -1}, number)
                          |> walk(steps, {1, 0}, number)

    if value > number do
      value
    else
      start_walking(new_map, current, steps + 2, number)
    end
  end

  defp walk({map, step, last_number}, 0, _, _), do: {map, step, last_number}
  defp walk({map, step, last_number}, _, _, number) when last_number > number do
    {map, step, last_number}
  end
  defp walk({map, previous_step, _}, steps, direction, number) do
    current = take_step(previous_step, direction)
    new_value = get_values(map, current)
    new_map = Map.put(map, current, new_value)
    result = {new_map, current, new_value}
    walk(result, steps - 1, direction, number)
  end

  defp take_step({prev_x, prev_y}, {dir_x, dir_y}) do
    {prev_x + dir_x, prev_y + dir_y}
  end

  defp get_values(map, {x, y}) do
    Map.get(map, {x-1, y}, 0)
    + Map.get(map, {x-1, y + 1}, 0)
    + Map.get(map, {x-1, y - 1}, 0)
    + Map.get(map, {x, y - 1}, 0)
    + Map.get(map, {x, y + 1}, 0)
    + Map.get(map, {x + 1, y - 1}, 0)
    + Map.get(map, {x + 1, y + 1}, 0)
    + Map.get(map, {x + 1, y}, 0)
  end
end

input = 347_991
IO.puts SpiralMemory.dist_to_core(input)
IO.puts SpiralMemory2.solve(input)
