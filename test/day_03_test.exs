defmodule Day03Test do
  use ExUnit.Case
  doctest Day03

  @sample_input """
  00100
  11110
  10110
  10111
  10101
  01111
  00111
  11100
  10000
  11001
  00010
  01010
  """

  @puzzle_input File.read!("priv/03.txt")

  test "part one example" do
    assert Day03.part_one(@sample_input) == 198
  end

  test "part one solution" do
    assert Day03.part_one(@puzzle_input) == 2_724_524
  end

  test "part two example" do
    assert Day03.part_two(@sample_input) == 230
  end

  @tag :unimplemented
  test "part two solution" do
    assert Day03.part_two(@puzzle_input) == nil
  end
end
