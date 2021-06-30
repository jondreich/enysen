defmodule EnysenWeb.ChannelLive do
  use Surface.LiveView
  use Surface.Component
  alias Enysen.Chats
  alias EnysenWeb.LiveHelpers
  alias EnysenWeb.Live.Components.{LivePlayer, LiveCard, Chat.Input, Chat.Message}

  @impl true
  def mount(params, session, socket) do
    if connected?(socket) and stream_is_live(params["channel"]), do: Chats.subscribe(%{topic: get_current_stream(params["channel"]).id})
    {:ok, assign(
      socket,
      channel: params["channel"],
      current_stream: get_current_stream(params["channel"]),
      current_user: LiveHelpers.get_user(socket, session),
      send_message: "send_message")}
  end

  defp get_current_stream(username) do
    Enysen.Content.get_current_stream(%{username: username})
  end

  defp stream_is_live(username) do
    get_current_stream(username) != nil
  end

  @impl true
  def handle_event("send_message", %{"Elixir.Enysen.Chats.ChatMessage" => %{"body" => message_body}}, socket) do
    case Chats.send_chat_message(%{body: message_body, user_id: socket.assigns.current_user.id, stream_id: socket.assigns.current_stream.id}) do
      {:ok, _chat_message} ->
        {:noreply, socket}
    end
  end
end
