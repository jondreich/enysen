defmodule Enysen.Users do
  import Ecto.Query, warn: false
  alias Enysen.Repo
  alias Enysen.Users.User
  alias Enysen.Users.Follower
  alias Enysen.Users.Channel

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

  def get_followers(username) do
    user =
      from u in User,
      where: u.username == ^username,
      select: u.id

    query =
      from f in Follower,
      where: f.user_id == ^List.first(Repo.all(user)),
      select: f.id

    Repo.all(query)
  end

  def check_following(attrs) do
    query =
      from f in Follower,
      where: f.follower_id == ^attrs.follower_id and f.user_id == ^attrs.user_id
    Repo.all(query) != []
  end

  def create_channel(%{user: user}) do
    %Channel{}
    |> Channel.changeset(%{stream_key: generate_stream_key(), user_id: user.id, bio: "#{user.username}'s Channel", stream_title: "#{user.username}'s Stream"})
    |> Repo.insert()
  end

  def update_channel(%Channel{} = channel, attrs) do
    channel
    |> Channel.changeset(attrs)
    |> Repo.update()
  end

  def get_channel(username) do
    query =
      from c in Channel,
      where: c.user_id == ^get_user_by_username(username).id

    List.first(Repo.all(query))
  end

  defp generate_stream_key() do
    Ecto.UUID.generate()
  end
end
