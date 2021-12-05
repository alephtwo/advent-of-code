defmodule MatrixTest do
  use ExUnit.Case
  doctest Matrix
  @moduletag :finished

  test "identity matrix transposed is itself" do
    identity = [[1, 0, 0], [0, 1, 0], [0, 0, 1]]
    assert Matrix.transpose(identity) == [[1, 0, 0], [0, 1, 0], [0, 0, 1]]
  end

  test "sample matrix should transpose correctly" do
    matrix = [[1, 2, 3], [4, 5, 6], [6, 7, 8]]
    assert Matrix.transpose(matrix) == [[1, 4, 6], [2, 5, 7], [3, 6, 8]]
  end
end
