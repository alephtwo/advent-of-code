defmodule Day06Test do
  use ExUnit.Case
  doctest Day06

  @sample_input "3,4,3,1,2\n"

  @puzzle_input File.read!("priv/06.txt")

  test "part one example" do
    assert Day06.part_one(@sample_input, 18) == 26
    assert Day06.part_one(@sample_input, 80) == 5_934
  end

  test "part one solution" do
    assert Day06.part_one(@puzzle_input, 80) == 386_755
  end

  @tag :cursed
  test "part two example" do
    assert Day06.part_two(@sample_input, 256) == 26_984_457_539
  end

  test "part two solution" do
    assert Day06.part_two(@puzzle_input, 256) == nil
  end
end
