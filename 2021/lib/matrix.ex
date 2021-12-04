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
  def transpose(matrix) do
    matrix
    |> List.zip()
    |> Enum.map(&Tuple.to_list/1)
  end
end
