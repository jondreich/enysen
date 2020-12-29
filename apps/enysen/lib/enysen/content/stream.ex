defmodule Enysen.Content.Stream do
  use Ecto.Schema
  import Ecto.Changeset

  @primary_key {:id, :binary_id, autogenerate: true}
  @foreign_key_type :binary_id

  schema "streams" do
    field :end_time, :utc_datetime
    field :start_time, :utc_datetime
    belongs_to :channel, Enysen.Users.Channel, foreign_key: :channel_id
    field :title, :string
    has_many :chat_messages, Enysen.Chats.ChatMessage

    timestamps()
  end

  @doc false
  def changeset(stream, attrs) do
    stream
    |> cast(attrs, [:title, :start_time, :end_time, :channel_id])
    |> validate_required([:title, :start_time, :channel_id])
  end
end
