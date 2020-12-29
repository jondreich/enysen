defmodule EnysenWeb.HomeLive do
  use Surface.LiveView
  use Surface.Component
  alias EnysenWeb.LiveHelpers
  alias EnysenWeb.Live.Components.{Label}

  @impl true
  def mount(_params, session, socket) do
    {:ok, assign(
      socket,
      current_user: LiveHelpers.get_user(socket, session))}
  end
end
