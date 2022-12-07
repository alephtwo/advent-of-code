defmodule Day07 do
  @moduledoc """
  Day 7 of Advent of Code 2022.
  """

  @doc """
  """
  @spec part_one(String.t()) :: number()
  def part_one(input) do
    %{sizes: sizes} =
      input
      |> parse_input()
      |> Enum.reduce(%{pwd: "/", sizes: %{}}, &process_line/2)

    # For each key, find the other keys that begin with the exact string
    dirsizes =
      Enum.reduce(Map.keys(sizes), %{}, fn path, acc ->
        bytes =
          sizes
          |> Map.filter(fn {k, _v} -> is_subdirectory?(k, path) end)
          |> Enum.map(fn {_, size} -> size end)
          |> Enum.sum()

        Map.update(acc, path, bytes, fn x -> x + bytes end)
      end)

    %{counted: _, total: total} =
      Enum.reduce(dirsizes, %{counted: MapSet.new(), total: 0}, fn {path, size}, acc ->
        cond do
          # skip if we've already included a parent
          MapSet.member?(acc.counted, path) ->
            acc

          # if the size isn't 100,000 or less, don't count it
          size <= 100_000 ->
            %{acc | counted: MapSet.put(acc.counted, path), total: acc.total + size}

          # do something??????
          true ->
            acc
        end
      end)

    total
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
        %{ctx | sizes: Map.update(ctx.sizes, ctx.pwd, bytes, fn x -> bytes + x end)}
    end
  end

  defp is_subdirectory?(one, two) do
    String.starts_with?(one, two)
  end
end
