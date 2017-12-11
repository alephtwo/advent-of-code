defmodule DaySevenTest do
  use ExUnit.Case
  doctest DaySeven

  test "parse string, no children" do
    parsed = DaySeven.parse_str("pbga (66)")
    assert parsed == %{weight: 66, name: "pbga", children: []}
  end

  test "parse string, one child" do
    parsed = DaySeven.parse_str("fwft (72) -> ktlj")
    assert parsed == %{ weight: 72, name: "fwft", children: ["ktlj"] }
  end

  test "parse string, multiple children" do
    parsed = DaySeven.parse_str("fwft (72) -> ktlj, cntj, xhth")
    assert parsed == %{
      weight: 72,
      name: "fwft",
      children: ["ktlj", "cntj", "xhth"]
    }
  end

  test "part one" do
    assert DaySeven.find_root(DaySeven.get_input()) == "hlhomy"
  end

  test "part two" do
    DaySeven.part_two
  end
end
