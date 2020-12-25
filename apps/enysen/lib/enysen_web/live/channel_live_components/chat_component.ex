defmodule EnysenWeb.ChannelLive.Chat do
  use EnysenWeb, :live_view
  alias Enysen.Chats

  @impl true
  def render(assigns) do
    ~L"""
    <div class="phx-hero" style="background: #121212; color: #f7f7f7; padding: 1em">
      <%= for message <- @chat_messages do %>
        <p style="text-align: left; font-size: 0.5em; margin: 0">
        <strong><%= message.user.username %></strong>: <%= message.body %>
        </p>
      <% end %>
    </div>
    <%= if @current_user do %>
      <%= f = form_for @message_changeset, "#", [phx_submit: :send_message] %>
        <%= text_input f, :body, placeholder: "Type message here..." %>
        <%= error_tag f, :body %>

        <%= submit "send" %>
        </form>
    <% end %>
    """
  end

  @impl true
  def mount(_params, %{"current_stream" => current_stream, "message_changeset" => message_changeset, "current_user" => current_user}, socket) do
    if connected?(socket), do: Chats.subscribe(%{topic: current_stream.id})
    {:ok, assign(
      socket,
      current_stream: current_stream,
      chat_messages: current_stream.chat_messages,
      message_changeset: message_changeset,
      current_user: current_user)}
  end

  @impl true
  def handle_event("send_message", %{"chat_message" => %{"body" => message_body}}, socket) do
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

  @impl true
  def handle_info({:chat_message_sent, message}, socket) do
    {:noreply, update(socket, :chat_messages, fn chat_messages -> chat_messages ++ [message] end)}
  end
end
