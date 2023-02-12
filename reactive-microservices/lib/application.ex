defmodule Pipelines.Application do
  @moduledoc false

  use Application

  @impl true
  def start(_type, _args) do
    children = [
      {Pipelines.Microservices.Broadway, []}
    ]

    opts = [strategy: :one_for_one, name: Pipelines.Supervisor]
    Supervisor.start_link(children, opts)
  end
end
