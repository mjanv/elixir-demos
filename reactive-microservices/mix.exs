defmodule Pipelines.MixProject do
  use Mix.Project

  def project do
    [
      app: :pipelines,
      version: "0.1.0",
      elixir: "~> 1.14",
      start_permanent: Mix.env() == :prod,
      deps: deps()
    ]
  end

  def application do
    [
      extra_applications: [:logger],
      mod: {Pipelines.Application, []}
    ]
  end

  defp deps do
    [
      {:broadway, "~> 1.0"},
      {:broadway_kafka, "~> 0.3"},
      {:brod, "~> 3.16"}
    ]
  end
end
