defmodule Enysen.Content.Stream do
  use Ecto.Schema
  import Ecto.Changeset

  @primary_key {:id, :binary_id, autogenerate: true}
  @foreign_key_type :binary_id

  schema "streams" do
    field :end_time, :utc_datetime
    field :start_time, :utc_datetime
    belongs_to :user, Enysen.Users.User, foreign_key: :user_id
    field :title, :string
    has_many :chat_messages, Enysen.Chats.ChatMessage

    timestamps()
  end

  @doc false
  def changeset(stream, attrs) do
    stream
    |> cast(attrs, [:title, :start_time, :end_time, :user_id])
    |> validate_required([:title, :start_time, :user_id])
  end
end
