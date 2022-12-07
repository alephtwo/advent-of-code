defmodule Day07Test do
  use ExUnit.Case
  doctest Day07

  @puzzle_input File.read!("priv/07.txt")

  @sample_input """
  $ cd /
  $ ls
  dir a
  14848514 b.txt
  8504156 c.dat
  dir d
  $ cd a
  $ ls
  dir e
  29116 f
  2557 g
  62596 h.lst
  $ cd e
  $ ls
  584 i
  $ cd ..
  $ cd ..
  $ cd d
  $ ls
  4060174 j
  8033020 d.log
  5626152 d.ext
  7214296 k
  """

  test "part 1 example" do
    assert Day07.part_one(@sample_input) == 95437
  end

  @tag :skip
  test "part 1 solution" do
    # first wrong answer
    assert Day07.part_one(@puzzle_input) > 1_377_938
    assert Day07.part_one(@puzzle_input) == :ok
  end

  @tag :skip
  test "part 2 example" do
    assert Day07.part_two(@sample_input) == :ok
  end

  @tag :skip
  test "part 2 solution" do
    assert Day07.part_two(@puzzle_input) == :ok
  end
end
