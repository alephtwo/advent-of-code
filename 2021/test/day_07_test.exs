defmodule Day07Test do
  use ExUnit.Case
  doctest Day07

  @sample_input """
  16,1,2,0,4,2,7,1,2,14
  """

  @puzzle_input File.read!("priv/07.txt")

  test "part one example" do
    assert Day07.part_one(@sample_input) == 37
  end

  test "part one solution" do
    assert Day07.part_one(@puzzle_input) == nil
  end

  @tag :unimplemented
  test "part two example" do
    assert Day07.part_two(@sample_input) == nil
  end

  @tag :unimplemented
  test "part two solution" do
    assert Day07.part_two(@puzzle_input) == nil
  end
end
