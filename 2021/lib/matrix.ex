defmodule Matrix do
  @moduledoc """
  Common matrix operations.
  """

  @doc """
  Transpose a matrix.
  Transposing a matrix can be considered "spinning it by 90 degrees."
  The values in the first column become the first row, and so on.

  If A is as follows:
  ```text
  1 2 3
  4 5 6
  7 8 9
  ```

  Then A^T is

  ```text
  1 4 7
  2 5 8
  3 6 9
  ```
  """
  @spec transpose(list(list(any()))) :: list(list(any()))
  def transpose(matrix) do
    matrix
    |> List.zip()
    |> Enum.map(&Tuple.to_list/1)
  end

  def index_matrix(matrix) do
    matrix
    |> Enum.map(&indexed_map/1)
    |> indexed_map()
  end

  def get_coordinate(matrix, x, y) when is_map(matrix) do
    value =
      matrix
      # there might not be anything there
      |> Map.get(y, %{})
      |> Map.get(x)

    case value do
      nil -> :not_found
      n -> n
    end
  end

  defp indexed_map(list), do: for({v, k} <- Stream.with_index(list), into: %{}, do: {k, v})
end
