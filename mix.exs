defmodule AdventOfCode2017.Mixfile do
  use Mix.Project

  def project do
    [
      app: :aoc2017,
      version: "0.1.0",
      elixir: "~> 1.5",
      start_permanent: Mix.env == :prod,
      deps: deps(),
      escript: [main_module: AdventOfCode2017]
    ]
  end

  def application do
    [extra_applications: [:logger]]
  end

  defp deps do
    []
  end
end
