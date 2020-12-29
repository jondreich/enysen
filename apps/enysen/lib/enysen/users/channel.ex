defmodule Enysen.Users.Channel do
  use Ecto.Schema
  import Ecto.Changeset

  @primary_key {:id, :binary_id, autogenerate: true}
  @foreign_key_type :binary_id

  schema "channels" do
    field :bio, :string
    field :stream_key, :string
    field :stream_title, :string
    belongs_to :user, Enysen.Users.User, foreign_key: :user_id

    timestamps()
  end

  @doc false
  def changeset(channel, attrs) do
    channel
    |> cast(attrs, [:user_id, :stream_title, :stream_key, :bio])
    |> validate_required([:user_id, :stream_title, :stream_key, :bio])
  end
end
