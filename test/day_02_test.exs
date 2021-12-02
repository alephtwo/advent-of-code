defmodule Day02Test do
  use ExUnit.Case
  doctest Day02

  @sample_input """
  forward 5
  down 5
  forward 8
  up 3
  down 8
  forward 2
  """

  @puzzle_input File.read!("priv/02.txt")

  test "part one example" do
    assert Day02.part_one(@sample_input) == 150
  end

  test "part one solution" do
    assert Day02.part_one(@puzzle_input) == 1_813_801
  end

  test "part two example" do
    assert Day02.part_two(@sample_input) == 900
  end

  test "part two solution" do
    assert Day02.part_two(@puzzle_input) == 1_960_569_556
  end
end
