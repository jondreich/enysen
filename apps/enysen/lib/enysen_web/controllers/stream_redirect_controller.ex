defmodule EnysenWeb.StreamRedirectController do
  use EnysenWeb, :controller
  alias Enysen.Repo
  import Ecto.Query

  def start_stream(conn, params) do
    query = from u in "users",
      where: u.stream_key == ^params["name"],
      select: u.username

    user = Repo.all(query)

    redirect(conn, external: "rtmp://127.0.0.1/dash/#{List.first(user)}")
  end
end
