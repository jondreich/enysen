defmodule Enysen.Content do
  import Ecto.Query, warn: false
  alias Enysen.Repo
  alias Enysen.Users
  alias Enysen.Content.Stream
  alias Enysen.Users.User

  def start_stream(params) do
    query = from u in User,
      where: u.stream_key == ^params.key

    user = List.first(Repo.all(query))

    %Stream{}
    |> Stream.changeset(%{title: user.stream_title, user_id: user.id, start_time: DateTime.utc_now()})
    |> Repo.insert()

    {:ok, user.username}
  end

  def end_stream(params) do
    query = from u in User,
      where: u.stream_key == ^params.key,
      select: u.id

    now = DateTime.utc_now()

    from(s in Stream, where: s.user_id in subquery(query) and is_nil(s.end_time), update: [set: [end_time: ^now]])
    |> Repo.update_all([])
  end

  def get_current_stream(params) do
    user = Users.get_user_by_username(params.username)

    query = from s in Stream,
      where: s.user_id == ^user.id and is_nil(s.end_time),
      preload: [chat_messages: :user]

    List.first(Repo.all(query))
  end
end
