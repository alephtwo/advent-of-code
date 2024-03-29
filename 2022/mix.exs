defmodule AdventOfCode2022.MixProject do
  use Mix.Project

  def project do
    [
      app: :advent_of_code_2022,
      version: "0.1.0",
      elixir: "~> 1.14",
      start_permanent: Mix.env() == :prod,
      deps: deps()
    ]
  end

  def application do
    [
      extra_applications: [:logger]
    ]
  end

  defp deps do
    [
      {:benchee, "~> 1.1"},
      {:libgraph, "~> 0.16.0"},
      {:credo, "~> 1.6", only: [:dev, :test], runtime: false},
      {:dialyxir, "~> 1.0", only: [:dev], runtime: false},
      {:ex_doc, "~> 0.29.1", only: [:dev], runtime: false}
    ]
  end
end
