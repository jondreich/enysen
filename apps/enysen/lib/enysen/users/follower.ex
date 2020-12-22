defmodule Enysen.Users.Follower do
  use Ecto.Schema
  import Ecto.Changeset
  alias Enysen.Users.User

  @primary_key {:id, :binary_id, autogenerate: true}
  @foreign_key_type :binary_id

  schema "followers" do
    belongs_to :user, User, foreign_key: :user_id
    belongs_to :follower, User, foreign_key: :follower_id

    timestamps()
  end

  @doc false
  def changeset(follower, attrs) do
    follower
    |> cast(attrs, [:user_id, :follower_id])
    |> validate_required([:user_id, :follower_id])
    |> unique_constraint([:user_id, :follower_id], name: :followers_follower_id_user_id_index, message: "already following")
  end
end
