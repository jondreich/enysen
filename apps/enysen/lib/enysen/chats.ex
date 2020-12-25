defmodule Enysen.Chats do
  import Ecto.Query, warn: false
  alias Enysen.Repo
  alias Enysen.Chats.ChatMessage

  def change_chat_message(%ChatMessage{} = chat_message, attrs \\ %{}) do
    ChatMessage.changeset(chat_message, attrs)
  end

  def send_chat_message(attrs \\ %{}) do
    message = %ChatMessage{}
    |> ChatMessage.changeset(attrs)
    |> Repo.insert!()
    |> Repo.preload(:user)

    broadcast(message, :chat_message_sent)
  end

  defp broadcast({:error, _reason} = error, _event), do: error

  defp broadcast(message, event) do
    Phoenix.PubSub.broadcast(Enysen.PubSub, "#{message.stream_id}", {event, message})
    {:ok, message}
  end

  def subscribe(params) do
    Phoenix.PubSub.subscribe(Enysen.PubSub, params.topic)
  end
end
