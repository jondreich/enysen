defmodule EnysenWeb.Live.Components.Chat.Message do
  use Surface.Component

  prop user, :string, default: "test"

  prop message, :string, required: true

  prop color, :string, default: "#f9d89c"

  def render(assigns) do
    ~H"""
    <p>
      <strong style="color:{{@color}}">{{ @user }}</strong>: {{ @message }}
    </p>
    """
  end
end
