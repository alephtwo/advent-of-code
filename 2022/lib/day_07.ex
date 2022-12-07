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

  defp parse_input(input) do
    input
    |> String.split("\n", trim: true)
    |> Enum.reduce(%{path: nil, dirs: %{}}, &process_line/2)
  end

  defp process_line("$ cd /", %{path: _, dirs: dirs}), do: %{path: [], dirs: dirs}
  defp process_line("$ cd ..", %{path: [_ | path], dirs: dirs}), do: %{path: path, dirs: dirs}
  defp process_line(<<"$ cd ", name::binary>>, %{path: path, dirs: dirs}), do: %{path: [name | path], dirs: dirs}
  defp process_line(<<"$ ls">>, %{path: path, dirs: dirs}), do: %{path: path, dirs: Map.put(dirs, path, %{subdirs: [], files: []})}
  defp process_line(<<"dir ", name::binary>>, %{path: path, dirs: dirs}) do
    newdirs = Map.update!(dirs, path, fn %{subdirs: subdirs, files: files} ->
      %{subdirs: [name | subdirs], files: files}
    end)
    %{path: path, dirs: newdirs}
  end
  defp process_line(file, %{path: path, dirs: dirs}) do
    [size, _] = String.split(file, " ")
    bytes = String.to_integer(size)
    newdirs =
      dirs
      |> Map.update!(path, fn %{subdirs: dirs, files: files} ->
        %{subdirs: dirs, files: [bytes | files]}
      end)
    %{path: path, dirs: newdirs}
  end
end
