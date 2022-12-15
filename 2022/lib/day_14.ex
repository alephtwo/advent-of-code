defmodule Day14 do
  @moduledoc """
  Day 14 of Advent of Code 2022.
  """
  @source {500, 0}

  @doc """
  The distress signal leads you to a giant waterfall! Actually, hang on - the
  signal seems like it's coming from the waterfall itself, and that doesn't make
  any sense. However, you do notice a little path that leads behind the
  waterfall.

  Correction: the distress signal leads you behind a giant waterfall! There
  seems to be a large cave system here, and the signal definitely leads further
  inside.

  As you begin to make your way deeper underground, you feel the ground rumble
  for a moment. Sand begins pouring into the cave! If you don't quickly figure
  out where the sand is going, you could quickly become trapped!

  Fortunately, your familiarity with analyzing the path of falling material will
  come in handy here. You scan a two-dimensional vertical slice of the cave
  above you (your puzzle input) and discover that it is mostly air with
  structures made of rock.

  Your scan traces the path of each solid rock structure and reports the x,y
  coordinates that form the shape of the path, where x represents distance to
  the right and y represents distance down. Each path appears as a single line
  of text in your scan. After the first point of each path, each point indicates
  the end of a straight horizontal or vertical line to be drawn from the
  previous point. For example:

  ```text
  498,4 -> 498,6 -> 496,6
  503,4 -> 502,4 -> 502,9 -> 494,9
  ```

  This scan means that there are two paths of rock; the first path consists of
  two straight lines, and the second path consists of three straight lines.
  (Specifically, the first path consists of a line of rock from 498,4 through
  498,6 and another line of rock from 498,6 through 496,6.)

  The sand is pouring into the cave from point 500,0.

  Drawing rock as #, air as ., and the source of the sand as +, this becomes:

  ```text
    4     5  5
    9     0  0
    4     0  3
  0 ......+...
  1 ..........
  2 ..........
  3 ..........
  4 ....#...##
  5 ....#...#.
  6 ..###...#.
  7 ........#.
  8 ........#.
  9 #########.
  ```

  Sand is produced one unit at a time, and the next unit of sand is not produced
  until the previous unit of sand comes to rest. A unit of sand is large enough
  to fill one tile of air in your scan.

  A unit of sand always falls down one step if possible. If the tile immediately
  below is blocked (by rock or sand), the unit of sand attempts to instead move
  diagonally one step down and to the left. If that tile is blocked, the unit of
  sand attempts to instead move diagonally one step down and to the right. Sand
  keeps moving as long as it is able to do so, at each step trying to move down,
  then down-left, then down-right. If all three possible destinations are
  blocked, the unit of sand comes to rest and no longer moves, at which point
  the next unit of sand is created back at the source.

  So, drawing sand that has come to rest as o, the first unit of sand simply
  falls straight down and then stops:

  ```text
  ......+...
  ..........
  ..........
  ..........
  ....#...##
  ....#...#.
  ..###...#.
  ........#.
  ......o.#.
  #########.
  ```

  The second unit of sand then falls straight down, lands on the first one, and
  then comes to rest to its left:

  ```text
  ......+...
  ..........
  ..........
  ..........
  ....#...##
  ....#...#.
  ..###...#.
  ........#.
  .....oo.#.
  #########.
  ```

  After a total of five units of sand have come to rest, they form this pattern:

  ```text
  ......+...
  ..........
  ..........
  ..........
  ....#...##
  ....#...#.
  ..###...#.
  ......o.#.
  ....oooo#.
  #########.
  ```

  After a total of 22 units of sand:

  ```text
  ......+...
  ..........
  ......o...
  .....ooo..
  ....#ooo##
  ....#ooo#.
  ..###ooo#.
  ....oooo#.
  ...ooooo#.
  #########.
  ```

  Finally, only two more units of sand can possibly come to rest:

  ```text
  ......+...
  ..........
  ......o...
  .....ooo..
  ....#ooo##
  ...o#ooo#.
  ..###ooo#.
  ....oooo#.
  .o.ooooo#.
  #########.
  ```

  Once all 24 units of sand shown above have come to rest, all further sand
  flows out the bottom, falling into the endless void. Just for fun, the path
  any new sand takes before falling forever is shown here with ~:

  ```text
  .......+...
  .......~...
  ......~o...
  .....~ooo..
  ....~#ooo##
  ...~o#ooo#.
  ..~###ooo#.
  ..~..oooo#.
  .~o.ooooo#.
  ~#########.
  ~..........
  ~..........
  ~..........
  ```

  Using your scan, simulate the falling sand. How many units of sand come to
  rest before sand starts flowing into the abyss below?
  """
  @spec part_one(String.t()) :: number()
  def part_one(input) do
    lines = parse_input(input)
    {left, right} = find_left_right(lines)
    bottom = find_bottom(lines)
    empty_cave = build_empty_matrix(left, right, bottom)
    cave = Enum.reduce(lines, empty_cave, &draw_line/2)

    cave
    |> drop_sand()
    |> then(fn {:ok, c} -> c end)
    |> Map.values()
    |> Enum.filter(fn c -> c == :sand end)
    |> Enum.count()
  end

  @doc """
  You realize you misread the scan. There isn't an endless void at the bottom of
  the scan - there's floor, and you're standing on it!

  You don't have time to scan the floor, so assume the floor is an infinite
  horizontal line with a y coordinate equal to two plus the highest y coordinate
  of any point in your scan.

  In the example above, the highest y coordinate of any point is 9, and so the
  floor is at y=11. (This is as if your scan contained one extra rock path like
  -infinity,11 -> infinity,11.) With the added floor, the example above now
  looks like this:

  ```text
          ...........+........
          ....................
          ....................
          ....................
          .........#...##.....
          .........#...#......
          .......###...#......
          .............#......
          .............#......
          .....#########......
          ....................
  <-- etc #################### etc -->
  ```

  To find somewhere safe to stand, you'll need to simulate falling sand until a
  unit of sand comes to rest at 500,0, blocking the source entirely and stopping
  the flow of sand into the cave. In the example above, the situation finally
  looks like this after 93 units of sand come to rest:

  ```text
  ............o............
  ...........ooo...........
  ..........ooooo..........
  .........ooooooo.........
  ........oo#ooo##o........
  .......ooo#ooo#ooo.......
  ......oo###ooo#oooo......
  .....oooo.oooo#ooooo.....
  ....oooooooooo#oooooo....
  ...ooo#########ooooooo...
  ..ooooo.......ooooooooo..
  #########################
  ```

  Using your scan, simulate the falling sand until the source of the sand
  becomes blocked. How many units of sand come to rest?
  """
  @padding 150
  @spec part_two(String.t()) :: number()
  def part_two(input) do
    lines = parse_input(input)

    {left, right} =
      lines
      |> find_left_right()
      # uhh just add some padding on either side, scuffed but it works
      |> then(fn {l, r} -> {l - @padding, r + @padding} end)

    bottom = find_bottom(lines)

    horizontal = fn y, type ->
      left..right
      |> Enum.map(fn x -> {{x, y}, type} end)
      |> Map.new()
    end

    empty_cave =
      build_empty_matrix(left, right, bottom)
      # draw a horizontal line of air at bottom + 1
      |> Map.merge(horizontal.(bottom + 1, :air))
      # draw a horizontal line of rock at bottom + 2
      |> Map.merge(horizontal.(bottom + 2, :rock))

    cave = Enum.reduce(lines, empty_cave, &draw_line/2)

    cave
    |> drop_sand_with_bottom()
    |> Map.values()
    |> Enum.filter(fn x -> x == :sand end)
    |> Enum.count()
  end

  defp drop_sand(cave) do
    case simulate_drop(cave, @source) do
      # if this drop goes off the map we just need to return the existing cave
      :rollback -> {:ok, cave}
      # otherwise just keep going
      {:continue, next} -> drop_sand(next)
    end
  end

  defp simulate_drop(cave, {x, y}) do
    down = {x, y + 1}
    down_left = {x - 1, y + 1}
    down_right = {x + 1, y + 1}

    cond do
      # look down
      !Map.has_key?(cave, down) ->
        :rollback

      Map.get(cave, down) == :air ->
        simulate_drop(cave, down)

      # look down left
      !Map.has_key?(cave, down_left) ->
        :rollback

      Map.get(cave, down_left) == :air ->
        simulate_drop(cave, down_left)

      # look down right
      !Map.has_key?(cave, down_right) ->
        :rollback

      Map.get(cave, down_right) == :air ->
        simulate_drop(cave, down_right)

      # come to a stop
      true ->
        {:continue, Map.put(cave, {x, y}, :sand)}
    end
  end

  defp drop_sand_with_bottom(cave) do
    if Map.get(cave, @source) == :sand do
      cave
    else
      cave
      |> simulate_drop_with_bottom(@source)
      |> drop_sand_with_bottom()
    end
  end

  defp simulate_drop_with_bottom(cave, {x, y}) do
    down = {x, y + 1}
    down_left = {x - 1, y + 1}
    down_right = {x + 1, y + 1}

    cond do
      Map.get(cave, down) == :air ->
        simulate_drop_with_bottom(cave, down)

      Map.get(cave, down_left) == :air ->
        simulate_drop_with_bottom(cave, down_left)

      Map.get(cave, down_right) == :air ->
        simulate_drop_with_bottom(cave, down_right)

      true ->
        Map.put(cave, {x, y}, :sand)
    end
  end

  defp parse_input(input) do
    input
    |> String.split("\n", trim: true)
    |> Enum.flat_map(&parse_line/1)
  end

  defp parse_line(line) do
    line
    |> String.split(" -> ", trim: true)
    |> Enum.map(&parse_coords/1)
    |> Enum.chunk_every(2, 1, :discard)
  end

  defp parse_coords(string) do
    string
    |> String.split(",")
    |> Enum.map(&String.to_integer/1)
    |> then(fn [x, y] -> {x, y} end)
  end

  defp find_left_right(lines) do
    lines
    |> Enum.flat_map(fn [{x1, _}, {x2, _}] -> [x1, x2] end)
    |> Enum.min_max()
  end

  defp find_bottom(lines) do
    lines
    |> Enum.flat_map(fn [{_, y1}, {_, y2}] -> [y1, y2] end)
    |> Enum.max()
  end

  defp build_empty_matrix(left, right, bottom) do
    0..bottom
    |> Enum.flat_map(fn y -> Enum.map(left..right, fn x -> {{x, y}, :air} end) end)
    |> Map.new()
  end

  # vertical lines
  defp draw_line([{x, y1}, {x, y2}], matrix) do
    Enum.reduce(y1..y2, matrix, fn y, m -> Map.put(m, {x, y}, :rock) end)
  end

  # horizontal lines
  defp draw_line([{x1, y}, {x2, y}], matrix) do
    Enum.reduce(x1..x2, matrix, fn x, m -> Map.put(m, {x, y}, :rock) end)
  end

  # defp print_cave(cave) do
  #   coords = Map.keys(cave)
  #
  #   {min_x, max_x} =
  #     coords
  #     |> Enum.map(fn {x, _} -> x end)
  #     |> Enum.min_max()
  #
  #   {min_y, max_y} =
  #     coords
  #     |> Enum.map(fn {_, y} -> y end)
  #     |> Enum.min_max()
  #
  #   Enum.each(min_y..max_y, fn y ->
  #     Enum.each(min_x..max_x, fn x ->
  #       char =
  #         case Map.get(cave, {x, y}) do
  #           :air -> "."
  #           :rock -> "#"
  #           :sand -> "o"
  #         end
  #
  #       IO.write(char)
  #     end)
  #
  #     IO.puts("")
  #   end)
  #
  #   cave
  # end
end
