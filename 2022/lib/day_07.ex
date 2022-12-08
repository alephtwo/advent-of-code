defmodule Day07 do
  @moduledoc """
  Day 7 of Advent of Code 2022.
  """

  defmodule State do
    # represent the path as an array
    defstruct path: [], structure: %{}
  end

  defmodule Directory do
    defstruct bytes: 0, subfolders: []
  end

  @doc """
  """
  @spec part_one(String.t()) :: number()
  def part_one(input) do
    contents = parse_input(input)
    {_, sizes} = Enum.reduce(Map.keys(contents), {contents, %{}}, &calc_size/2)

    sizes
    |> Map.values()
    |> Enum.filter(fn x -> x <= 100_000 end)
    |> Enum.sum()
  end

  @doc """
  """
  @spec part_two(String.t()) :: number()
  def part_two(input) do
    contents = parse_input(input)
    {_, sizes} = Enum.reduce(Map.keys(contents), {contents, %{}}, &calc_size/2)

    free_space = 70_000_000 - Map.get(sizes, [])
    needed_space = 30_000_000 - free_space

    sizes
    |> Enum.filter(fn {_, bytes} -> bytes >= needed_space end)
    |> Enum.map(fn {path, size} -> size end)
    |> Enum.min()
  end

  # returns a map of paths to their contents
  defp parse_input(input) do
    input
    |> String.split("\n", trim: true)
    |> Enum.reduce(%State{}, &ingest_line/2)
    |> then(fn %State{path: _, structure: s} -> s end)
  end

  defp ingest_line(<<"$ cd ", dir::binary>>, state) do
    path =
      case dir do
        "/" ->
          []

        ".." ->
          Enum.drop(state.path, -1)

        dir ->
          Enum.reverse([dir | Enum.reverse(state.path)])
      end

    %State{state | path: path}
  end

  defp ingest_line("$ ls", state) do
    %State{state | structure: Map.put(state.structure, state.path, %Directory{})}
  end

  defp ingest_line(<<"dir ", dir::binary>>, state) do
    structure =
      Map.update!(state.structure, state.path, fn d ->
        %Directory{d | subfolders: Enum.reverse([dir | Enum.reverse(d.subfolders)])}
      end)

    %State{state | structure: structure}
  end

  defp ingest_line(line, state) do
    [size, name] = String.split(line, " ")

    structure =
      Map.update!(state.structure, state.path, fn d ->
        %Directory{d | bytes: d.bytes + String.to_integer(size)}
      end)

    %State{state | structure: structure}
  end

  defp calc_size(path, {contents, acc}) do
    %Directory{
      subfolders: subfolders,
      bytes: bytes
    } = Map.get(contents, path)

    if Enum.empty?(subfolders) do
      {contents, Map.put(acc, path, bytes)}
    else
      fullpaths = Enum.map(subfolders, fn s -> Enum.reverse([s | Enum.reverse(path)]) end)
      # This determines the sizes of all subdirectories
      {_, sizes} = Enum.reduce(fullpaths, {contents, %{}}, &calc_size/2)
      {contents, Map.put(acc, path, bytes + Enum.sum(Map.values(sizes)))}
    end
  end
end
