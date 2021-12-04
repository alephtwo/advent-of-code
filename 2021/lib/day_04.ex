defmodule Day04 do
  @moduledoc """
  Day 4 of the Advent of Code 2021.
  """
  @type position_t :: %{marked: boolean(), value: integer()}
  @type board_t :: list(list(position_t()))

  @doc """
  You're already almost 1.5km (almost a mile) below the surface of the ocean,
  already so deep that you can't see any sunlight. What you can see, however, is
  a giant squid that has attached itself to the outside of your submarine.

  Maybe it wants to play bingo?

  Bingo is played on a set of boards each consisting of a 5x5 grid of numbers.
  Numbers are chosen at random, and the chosen number is marked on all boards on
  which it appears. (Numbers may not appear on all boards.) If all numbers in
  any row or any column of a board are marked, that board wins. (Diagonals don't
  count.)

  The submarine has a bingo subsystem to help passengers (currently, you and the
  giant squid) pass the time. It automatically generates a random order in which
  to draw numbers and a random set of boards (your puzzle input). For example:

  ```text
  7,4,9,5,11,17,23,2,0,14,21,24,10,16,13,6,15,25,12,22,18,20,8,19,3,26,1

  22 13 17 11  0
   8  2 23  4 24
  21  9 14 16  7
   6 10  3 18  5
   1 12 20 15 19

   3 15  0  2 22
   9 18 13 17  5
  19  8  7 25 23
  20 11 10 24  4
  14 21 16 12  6

  14 21 17 24  4
  10 16 15  9 19
  18  8 23 26 20
  22 11 13  6  5
   2  0 12  3  7
  ```

  After the first five numbers are drawn (`7`, `4`, `9`, `5`, and `11`), there
  are no winners, but the boards are marked as follows (shown here adjacent to
  each other to save space):

  <pre>
  22 13 17 <b>11</b>  0         3 15  0  2 22        14 21 17 24  <b>4</b><br />
   8  2 23  <b>4</b> 24         <b>9</b> 18 13 17  <b>5</b>        10 16 15  <b>9</b> 19<br />
  21  <b>9</b> 14 16  <b>7</b>        19  8  <b>7</b> 25 23        18  8 23 26 20<br />
   6 10  3 18  <b>5</b>        20 <b>11</b> 10 24  <b>4</b>        22 <b>11</b> 13  6  <b>5</b><br />
   1 12 20 15 19        14 21 16 12  6         2  0 12  3  <b>7</b><br />
  </pre>

  After the next six numbers are drawn (17, 23, 2, 0, 14, and 21), there are
  still no winners:

  <pre>
  22 13 <b>17</b> <b>11</b>  <b>0</b>         3 15  <b>0</b>  <b>2</b> 22        <b>14</b> <b>21</b> <b>17</b> 24  <b>4</b><br />
   8  <b>2</b> <b>23</b>  <b>4</b> 24         <b>9</b> 18 13 <b>17</b>  <b>5</b>        10 16 15  <b>9</b> 19<br />
  <b>21</b>  <b>9</b> <b>14</b> 16  <b>7</b>        19  8  <b>7</b> 25 <b>23</b>        18  8 <b>23</b> 26 20<br />
   6 10  3 18  <b>5</b>        20 <b>11</b> 10 24  <b>4</b>        22 <b>11</b> 13  6  <b>5</b><br />
   1 12 20 15 19        <b>14</b> <b>21</b> 16 12  6         <b>2</b>  <b>0</b> 12  3  <b>7</b><br />
  </pre>

  Finally, 24 is drawn:

  <pre>
  22 13 <b>17</b> <b>11</b>  <b>0</b>         3 15  <b>0</b>  <b>2</b> 22        <b>14</b> <b>21</b> <b>17</b> <b>24</b>  <b>4</b><br />
   8  <b>2</b> <b>23</b>  <b>4</b> <b>24</b>         <b>9</b> 18 13 <b>17</b>  <b>5</b>        10 16 15  <b>9</b> 19<br />
  <b>21</b>  <b>9</b> <b>14</b> 16  <b>7</b>        19  8  <b>7</b> 25 <b>23</b>        18  8 <b>23</b> 26 20<br />
   6 10  3 18  <b>5</b>        20 <b>11</b> 10 <b>24</b>  <b>4</b>        22 <b>11</b> 13  6  <b>5</b><br />
   1 12 20 15 19        <b>14</b> <b>21</b> 16 12  6         <b>2</b>  <b>0</b> 12  3  <b>7</b><br />
  </pre>

  At this point, the third board wins because it has at least one complete row
  or column of marked numbers (in this case, the entire top row is marked:
  `14 21 17 24 4`).

  The score of the winning board can now be calculated. Start by finding the sum
  of all unmarked numbers on that board; in this case, the sum is `188`. Then,
  multiply that sum by the number that was just called when the board won, `24`,
  to get the final score, `188 * 24 = 4512`.

  To guarantee victory against the giant squid, figure out which board will win
  first. What will your final score be if you choose that board?
  """
  @spec part_one(String.t()) :: integer()
  def part_one(input) do
    data = input |> parse_input()

    {winning_board, last_number} =
      data.draw_order
      |> Enum.reduce_while(data.boards, &find_first_winning_board/2)

    score_board(winning_board, last_number)
  end

  @doc """
  On the other hand, it might be wise to try a different strategy: let the giant
  squid win.

  You aren't sure how many bingo boards a giant squid could play at once, so
  rather than waste time counting its arms, the safe thing to do is to figure
  out which board will win last and choose that one. That way, no matter which
  boards it picks, it will win for sure.

  In the above example, the second board is the last to win, which happens after
  13 is eventually called and its middle column is completely marked. If you
  were to keep playing until this point, the second board would have a sum of
  unmarked numbers equal to 148 for a final score of `148 * 13 = 1924`.

  Figure out which board will win last. Once it wins, what would its final score
  be?
  """
  @spec part_two(String.t()) :: integer()
  def part_two(input) do
    data = input |> parse_input()

    {final_board, last_number} =
      data.draw_order
      |> Enum.reduce_while(data.boards, &find_last_winning_board/2)

    score_board(final_board, last_number)
  end

  @spec parse_input(String.t()) :: %{draw_order: list(integer()), boards: list(board_t())}
  defp parse_input(raw) do
    [first | rest] = String.split(raw, "\n\n", trim: true)

    draw_order =
      first
      |> String.split(",", trim: true)
      |> Enum.map(&String.to_integer/1)

    boards =
      rest
      |> Enum.map(fn b -> String.split(b, "\n", trim: true) end)
      |> Enum.map(&parse_board/1)

    %{draw_order: draw_order, boards: boards}
  end

  # Turn the raw, textual representation of a board into a data structure we
  # can work with.
  @spec parse_board(String.t()) :: board_t()
  defp parse_board(raw) do
    raw
    |> Enum.map(fn r ->
      r
      |> String.split(" ", trim: true)
      |> Enum.map(fn x -> %{marked: false, value: String.to_integer(x)} end)
    end)
  end

  # Find the first board that wins with the given game.
  @spec find_first_winning_board(integer(), list(board_t())) ::
          {:halt, {board_t(), integer()}} | {:cont, list(board_t())}
  defp find_first_winning_board(drawn_number, boards) do
    boards_with_mark = mark_boards(boards, drawn_number)

    # Check to see if there is a winner amongst the boards.
    winners =
      boards_with_mark
      |> Enum.filter(&has_board_won/1)

    case winners do
      [a] -> {:halt, {a, drawn_number}}
      _ -> {:cont, boards_with_mark}
    end
  end

  # Find the last board that wins with the given game.
  @spec find_last_winning_board(integer(), list(board_t())) ::
          {:halt, {board_t(), integer()}} | {:cont, list(board_t())}
  defp find_last_winning_board(drawn_number, boards) do
    boards_with_mark = mark_boards(boards, drawn_number)

    # Remove the boards which still haven't won.
    not_yet_winners =
      Enum.filter(boards_with_mark, fn b ->
        !has_board_won(b)
      end)

    case not_yet_winners do
      # MAKE A VERY BOLD ASSUMPTION THAT THERE WILL BE A SINGLE LAST BOARD
      # IF THERE IS MORE THAN ONE IT WILL JUST PICK THE FIRST ONE
      [] -> {:halt, {Enum.at(boards_with_mark, 0), drawn_number}}
      _ -> {:cont, not_yet_winners}
    end
  end

  # Mark the drawn number on every board.
  @spec mark_boards(list(board_t()), integer()) :: list(board_t())
  defp mark_boards(boards, drawn_number) do
    Enum.map(boards, fn board ->
      Enum.map(board, fn row -> set_marked_in_row(row, drawn_number) end)
    end)
  end

  # Mark the drawn number on every row provided.
  @spec set_marked_in_row(list(position_t()), integer()) :: list(number())
  defp set_marked_in_row(row, drawn_number) do
    Enum.map(row, fn col -> set_marked_in_column(col, drawn_number) end)
  end

  # Mark the drawn number on the column, if necessary.
  @spec set_marked_in_column(position_t(), integer()) :: position_t()
  defp set_marked_in_column(col, drawn_number) do
    case col.value == drawn_number do
      true -> %{marked: true, value: col.value}
      false -> col
    end
  end

  # Determine if the given board has a winning row or column.
  @spec has_board_won(board_t()) :: boolean()
  defp has_board_won(board) do
    transposed = Matrix.transpose(board)

    check_rows = fn board ->
      Enum.any?(board, fn row ->
        Enum.all?(row, fn col -> col.marked end)
      end)
    end

    check_rows.(board) || check_rows.(transposed)
  end

  # Determine the score of the given board, provided the last number drawn.
  @spec score_board(board_t(), integer()) :: integer()
  defp score_board(board, last_number) do
    # Remove marked numbers
    score_from_unmarked =
      board
      |> Enum.map(fn row ->
        row
        |> Enum.filter(fn col -> !col.marked end)
        |> Enum.map(fn %{value: v} -> v end)
        |> Enum.sum()
      end)
      |> Enum.sum()

    score_from_unmarked * last_number
  end
end
