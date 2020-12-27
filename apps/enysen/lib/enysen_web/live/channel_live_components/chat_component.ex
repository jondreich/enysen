defmodule EnysenWeb.ChannelLive.Chat do
  use EnysenWeb, :live_view
  alias Enysen.Chats

  @impl true
  def render(assigns) do
    ~L"""
    <div class="channel__chat-area__chat-component">
      <div class="channel__chat-area__chat-component__messages-area">
        <%= for message <- @chat_messages do %>
          <p>
          <strong><%= message.user.username %></strong>: <%= message.body %>
          </p>
        <% end %>
      </div>
      <%= if @current_user do %>
        <div class="channel__chat-area__chat-component__input-area">
          <%= f = form_for @message_changeset, "#", [phx_submit: :send_message] %>
            <%= textarea f, :body, placeholder: "Type message here...", maxlength: 180 %>
            <%= error_tag f, :body %>

            <%= submit "send" %>
          </form>
        </div>
      <% end %>
    </div>
    """
  end

  @impl true
  def mount(_params, %{"current_stream" => current_stream, "message_changeset" => message_changeset, "current_user" => current_user, "username" => username}, socket) do
    if connected?(socket), do: Chats.subscribe(%{topic: current_stream.id})
    {:ok, assign(
      socket,
      current_stream: current_stream,
      chat_messages: current_stream.chat_messages,
      message_changeset: message_changeset,
      current_user: current_user,
      username: username)}
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
