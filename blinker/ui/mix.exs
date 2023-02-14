defmodule Ui.MixProject do
  use Mix.Project

  def project do
    [
      app: :ui,
      version: "0.1.0",
      elixir: "~> 1.12",
      elixirc_paths: elixirc_paths(Mix.env()),
      compilers: [:gettext] ++ Mix.compilers(),
      start_permanent: Mix.env() == :prod,
      aliases: aliases(),
      deps: deps()
    ]
  end

  def application do
    [
      mod: {Ui.Application, []},
      extra_applications: [:logger, :runtime_tools, :os_mon]
    ]
  end

  defp elixirc_paths(:test), do: ["lib", "test/support"]
  defp elixirc_paths(_), do: ["lib"]

  defp deps do
    [
      {:phoenix, "~> 1.6"},
      {:phoenix_html, "~> 3.3"},
      {:phoenix_live_reload, "~> 1.4", only: :dev},
      {:phoenix_live_view, "~> 0.18"},
      {:floki, "~> 0.34", only: :test},
      {:phoenix_live_dashboard, "~> 0.7"},
      {:esbuild, "~> 0.6", runtime: Mix.env() == :dev && Mix.target() == :host},
      {:telemetry_metrics, "~> 0.6"},
      {:telemetry_poller, "~> 1.0"},
      {:gettext, "~> 0.22"},
      {:jason, "~> 1.2"},
      {:plug_cowboy, "~> 2.6"},
      {:tailwind, "~> 0.1", runtime: Mix.env() == :dev && Mix.target() == :host}
    ]
  end

  defp aliases do
    [
      setup: ["deps.get"],
      "assets.deploy": ["tailwind default --minify", "esbuild default --minify", "phx.digest"],
    ]
  end
end
