defmodule Enysen.Users.User do
  use Ecto.Schema
  use Pow.Ecto.Schema

  import Ecto.Changeset

  alias Ecto.Changeset

  @primary_key {:id, :binary_id, autogenerate: true}

  schema "users" do
    pow_user_fields()

    field :username, :string, unique: true
    field :stream_key, :string
    field :stream_title, :string, default: "Stream Title"
    field :bio, :string, default: ""

    timestamps()
  end

  @doc false
  def changeset(user, attrs) do
    user
    |> pow_changeset(attrs)
    |> cast(attrs, [:username, :stream_title, :bio])
    |> unique_constraint(:username, name: :users_username_index, message: "username already in use")
    |> Changeset.change(%{stream_key: Ecto.UUID.generate()})
  end
end
