defmodule Day06Test do
  use ExUnit.Case
  doctest Day06

  @puzzle_input File.read!("priv/06.txt")

  @sample_input_1 "mjqjpqmgbljsphdztnvjfqwrcgsmlb"
  @sample_input_2 "bvwbjplbgvbhsrlpgdmjqwftvncz"
  @sample_input_3 "nppdvjthqldpwncqszvftbrmjlhg"
  @sample_input_4 "nznrnfrfntjfmvfwmzdfjlvtqnbhcprsg"
  @sample_input_5 "zcfzfwzzqfrljwzlrfnpqdbhtmscgvjw"

  test "part 1 example 1" do
    assert Day06.part_one(@sample_input_1) == 7
  end

  test "part 1 example 2" do
    assert Day06.part_one(@sample_input_2) == 5
  end

  test "part 1 example 3" do
    assert Day06.part_one(@sample_input_3) == 6
  end

  test "part 1 example 4" do
    assert Day06.part_one(@sample_input_4) == 10
  end

  test "part 1 example 5" do
    assert Day06.part_one(@sample_input_5) == 11
  end

  @tag :skip
  test "part 1 solution" do
    assert Day06.part_one(@puzzle_input) == :ok
  end

  @tag :skip
  test "part 2 example" do
    assert Day06.part_two(@sample_input) == :ok
  end

  @tag :skip
  test "part 2 solution" do
    assert Day06.part_two(@puzzle_input) == :ok
  end
end
