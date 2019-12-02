defmodule IntcodeComputerTest do
  use ExUnit.Case
  doctest IntcodeComputer

  test "1,0,0,0,99" do
    assert IntcodeComputer.run_program([1, 0, 0, 0, 99]) == [2, 0, 0, 0, 99]
  end

  test "2,3,0,3,99" do
    assert IntcodeComputer.run_program([2, 3, 0, 3, 99 ]) == [2, 3, 0, 6, 99]
  end

  test "2,4,4,5,99,0" do
    output = IntcodeComputer.run_program([2, 4, 4, 5, 99, 0])
    assert output == [2, 4, 4, 5, 99, 9801]
  end

  test "1,1,1,4,99,5,6,0,99" do
    output = IntcodeComputer.run_program([1, 1, 1, 4, 99, 5, 6, 0, 99])
    assert output == [30, 1, 1, 4, 2, 5, 6, 0, 99]
  end
end
