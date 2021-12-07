defmodule Day07Test do
  use ExUnit.Case
  doctest Day07
  @moduletag :finished

  @sample_input """
  16,1,2,0,4,2,7,1,2,14
  """

  @puzzle_input File.read!("priv/07.txt")

  test "part one example" do
    assert Day07.part_one(@sample_input) == 37
  end

  test "part one solution" do
    assert Day07.part_one(@puzzle_input) == 323_647
  end

  test "part two example" do
    assert Day07.part_two(@sample_input) == 168
  end

  test "part two solution" do
    assert Day07.part_two(@puzzle_input) == 87_640_209
  end
end
