defmodule Day02Test do
  use ExUnit.Case
  doctest Day02

  test "1,0,0,0,99 part one" do
    assert_programs_eq("1,0,0,0,99", "2,0,0,0,99")
  end

  test "2,3,0,3,99 part one" do
    assert_programs_eq("2,3,0,3,99", "2,3,0,6,99")
  end

  test "2,4,4,5,99,0 part one" do
    assert_programs_eq("2,4,4,5,99,0", "2,4,4,5,99,9801")
  end

  test "1,1,1,4,99,5,6,0,99 part one" do
    assert_programs_eq("1,1,1,4,99,5,6,0,99", "30,1,1,4,2,5,6,0,99")
  end

  defp assert_programs_eq(input, output) do
    executed_program = Day02.run_program(input) |> Enum.join(",")
    assert executed_program == output
  end
end
