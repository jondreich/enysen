defmodule EnysenWeb.Live.Components.Label do
  use Surface.Component

  prop help, :string, required: true, default: "fuck"

  def render(assigns) do
    ~H"""
    {{ @help }}
    """
  end
end
