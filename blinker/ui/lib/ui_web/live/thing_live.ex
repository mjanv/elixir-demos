defmodule UiWeb.ThingLive do
  @moduledoc false

  use UiWeb, :live_view

  def mount(_params, _session, socket) do
    if connected?(socket) do
      Phoenix.PubSub.subscribe(Ui.PubSub, "led")
    end

    {:ok, assign(socket, :status, "?")}
  end

  def render(assigns) do
    ~H"""
    <%= @status %>
    """
  end

  def handle_event("on", _params, socket) do
    {:noreply, assign(socket, :status, "green")}
  end

  def handle_event("off", _params, socket) do
    {:noreply, assign(socket, :status, "red")}
  end

end
