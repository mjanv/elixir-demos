defmodule HelloNerves.Application do
  @moduledoc false

  use Application

  @impl true
  def start(_type, _args) do
    Application.get_env(:hello_nerves, :target)
    |> children()
    |> Supervisor.start_link(strategy: :one_for_one, name: HelloNerves.Supervisor)
  end

  def children(:host), do: []

  def children(_target) do
    [
      Blinker,
      {Plug.Cowboy, scheme: :http, plug: Http, options: [port: 8080]}
    ]
  end
end
