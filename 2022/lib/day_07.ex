defmodule Day07 do
  @moduledoc """
  Day 7 of Advent of Code 2022.
  """

  @doc """
  """
  @spec part_one(String.t()) :: number()
  def part_one(input) do
    input
    |> parse_input()
    |> Enum.reduce(%{pwd: "/", sizes: %{}}, &process_line/2)
    |> IO.inspect()
  end

  @doc """
  """
  @spec part_two(String.t()) :: number()
  def part_two(input) do
    input
    |> parse_input()
    |> IO.inspect()
  end

  defp parse_input(input), do: String.split(input, "\n", trim: true)

  # Handle commands.
  defp process_line("$ " <> cmd, ctx) do
    case cmd do
      "ls" ->
        # Do nothing, this is just context for the next few lines.
        ctx

      "cd " <> dir ->
        case dir do
          # Move to root
          "/" ->
            %{ctx | pwd: "/"}

          # Move up a path
          ".." ->
            %{ctx | pwd: ctx.pwd |> Path.split() |> Enum.drop(-1) |> Path.join()}

          # Move down to the directory selected
          _ ->
            %{ctx | pwd: Path.join(ctx.pwd, dir)}
        end

      _ ->
        throw("what cmd is this? #{cmd}")
    end
  end

  defp process_line(line, ctx) do
    case line do
      "dir " <> _dir ->
        ctx

      _ ->
        [size, _] = String.split(line, " ", trim: true)
        bytes = String.to_integer(size)
        %{ ctx | sizes: Map.update(ctx.sizes, ctx.pwd, bytes, fn x -> bytes + x end)}
    end
  end
end
