defmodule EnysenWeb.ChannelLive do
  use Surface.LiveView
  use Surface.Component
  alias Enysen.Chats
  alias EnysenWeb.LiveHelpers
  alias EnysenWeb.Live.Components.{LivePlayer, Chat.Input, Chat.Message}

  @impl true
  def mount(params, session, socket) do
    if connected?(socket), do: Chats.subscribe(%{topic: get_current_stream(params["channel"]).id})
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

  @impl true
  def handle_event("send_message", %{"Elixir.Enysen.Chats.ChatMessage" => %{"body" => message_body}}, socket) do
    case Chats.send_chat_message(%{body: message_body, user_id: socket.assigns.current_user.id, stream_id: socket.assigns.current_stream.id}) do
      {:ok, _chat_message} ->
        {:noreply, socket}
      {:error, any} ->
        IO.inspect(any)
        {:noreply,
        socket
        |> put_flash(:error, "OOPSIE WOOPSIE!! Uwu We made a fucky wucky!! A wittle fucko boingo! The code monkeys at our headquarters are working VEWY HAWD to fix this!")}
    end
  end
end
