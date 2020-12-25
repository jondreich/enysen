defmodule Enysen.Chats.ChatMessage do
  use Ecto.Schema
  import Ecto.Changeset

  @primary_key {:id, :binary_id, autogenerate: true}
  @foreign_key_type :binary_id

  schema "chat_messages" do
    field :body, :string
    belongs_to :stream, Enysen.Content.Stream, foreign_key: :stream_id
    belongs_to :user, Enysen.Users.User, foreign_key: :user_id

    timestamps()
  end

  @doc false
  def changeset(chat_message, attrs) do
    chat_message
    |> cast(attrs, [:user_id, :stream_id, :body])
    |> validate_required([:user_id, :stream_id, :body])
  end
end
