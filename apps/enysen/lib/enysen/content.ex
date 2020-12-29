defmodule Enysen.Content do
  import Ecto.Query, warn: false
  alias Enysen.Repo
  alias Enysen.Users
  alias Enysen.Content.Stream
  alias Enysen.Users.User
  alias Enysen.Users.Channel

  def start_stream(params) do
    channel_query = from c in Channel,
      where: c.stream_key == ^params.key

    case List.first(Repo.all(channel_query)) do
      nil ->
        {:error, "not found"}
      channel ->
        query = from u in User,
          where: u.id == ^channel.user_id

        user = List.first(Repo.all(query))

        case %Stream{}
        |> Stream.changeset(%{title: channel.stream_title, channel_id: channel.id, start_time: DateTime.utc_now()})
        |> Repo.insert() do
          {:ok, _} ->
            {:ok, user.username}
          {:error, error} ->
            {:error, error}
        end
    end
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
    case Users.get_channel(params.username) do
      nil ->
        nil
      channel ->
        query = from s in Stream,
        where: s.channel_id == ^channel.id and is_nil(s.end_time),
        preload: [chat_messages: :user]
      List.first(Repo.all(query))
    end

  end
end
