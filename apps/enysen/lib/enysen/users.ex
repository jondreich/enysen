defmodule Enysen.Users do
  import Ecto.Query, warn: false
  alias Enysen.Repo
  alias Enysen.Users.User
  alias Enysen.Users.Follower

  def follow(attrs \\ %{}) do
    %Follower{}
    |> Follower.changeset(attrs)
    |> Repo.insert()
  end

  def unfollow(attrs) do
    query =
      from f in Follower,
        where: f.follower_id == ^attrs.follower_id and f.user_id == ^attrs.user_id

    {:ok, Repo.delete_all(query)}
  end

  def get_user_by_username(username) do
    query =
      from u in User,
      where: u.username == ^username
    List.first(Repo.all(query))
  end

  def get_follower_count(username) do
    user =
      from u in User,
      where: u.username == ^username,
      select: u.id

    query =
      from f in Follower,
      where: f.user_id == ^List.first(Repo.all(user)),
      select: f.id

    length(Repo.all(query))
  end

  def check_following(attrs) do
    query =
      from f in Follower,
      where: f.follower_id == ^attrs.follower_id and f.user_id == ^attrs.user_id
    Repo.all(query) != []
  end
end
