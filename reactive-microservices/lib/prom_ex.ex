defmodule Pipelines.PromEx do
  @moduledoc false

  use PromEx, otp_app: :pipelines

  alias PromEx.Plugins

  @impl true
  def plugins do
    [
      Plugins.Application,
      Plugins.Beam,
      PromEx.Plugins.Broadway
    ]
  end

  @impl true
  def dashboard_assigns do
    [
      datasource_id: "ok",
      default_selected_interval: "30s"
    ]
  end

  @impl true
  def dashboards do
    [
      {:prom_ex, "application.json"},
      {:prom_ex, "beam.json"},
      {:prom_ex, "broadway.json"}
    ]
  end
end
