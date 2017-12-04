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

IO.puts SpiralMemory.dist_to_core(347_991)
