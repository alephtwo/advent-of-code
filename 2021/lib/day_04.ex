defmodule Day04 do
  @moduledoc """
  Day 4 of the Advent of Code 2021.
  """

  def part_one(input) do
    data = input |> parse_input()

    {winning_board, last_number} =
      data.draw_order
      |> Enum.reduce_while(data.boards, &find_first_winning_board/2)

    score_board(winning_board, last_number)
  end

  def part_two(input) do
    input
    |> parse_input()
  end

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

  defp parse_board(raw) do
    raw
    |> Enum.map(fn r ->
      r
      |> String.split(" ", trim: true)
      |> Enum.map(fn x -> %{marked: false, value: String.to_integer(x)} end)
    end)
  end

  defp find_first_winning_board(drawn_number, boards) do
    boards_with_mark =
      boards
      |> Enum.map(fn board ->
        board
        |> Enum.map(fn row ->
          row
          |> Enum.map(fn col ->
            case col.value == drawn_number do
              true -> %{marked: true, value: col.value}
              false -> col
            end
          end)
        end)
      end)

    # Check to see if there is a winner amongst the boards.
    winners =
      boards_with_mark
      |> Enum.filter(&has_board_won/1)

    case winners do
      [a] -> {:halt, {a, drawn_number}}
      _ -> {:cont, boards_with_mark}
    end
  end

  defp has_board_won(board) do
    transposed = Matrix.transpose(board)

    check_rows = fn board ->
      Enum.any?(board, fn row ->
        Enum.all?(row, fn col -> col.marked end)
      end)
    end

    check_rows.(board) || check_rows.(transposed)
  end

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
