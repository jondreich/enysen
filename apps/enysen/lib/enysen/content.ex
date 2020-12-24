defmodule Enysen.Content do
  import Ecto.Query, warn: false
  alias Enysen.Repo
  alias Enysen.Content.Stream
  alias Enysen.Users.User

  def start_stream(attrs) do
    query = from u in User,
      where: u.stream_key == ^attrs.key

    user = List.first(Repo.all(query))

    %Stream{}
    |> Stream.changeset(%{title: user.stream_title, user_id: user.id, start_time: DateTime.utc_now()})
    |> Repo.insert()

    {:ok, user.username}
  end

  def end_stream(attrs) do
    query = from u in User,
      where: u.stream_key == ^attrs.key,
      select: u.id

    now = DateTime.utc_now()

    from(s in Stream, where: s.user_id in subquery(query) and is_nil(s.end_time), update: [set: [end_time: ^now]])
    |> Repo.update_all([])
  end
end
