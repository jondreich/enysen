defmodule EnysenWeb.ChannelController do
  use EnysenWeb, :controller
  alias Enysen.Users

  def channel(conn, params) do
    if user_exists(params["username"]) do
      render(conn, "channel.html",
        username: params["username"],
        live_video_source: "http://192.168.1.224:8080/dash/#{params["username"]}/index.mpd",
        follower_count: user_follower_count(params["username"]))
    else
      render(conn, "channel.html",
        username: nil)
    end
  end

  defp user_exists(username) do
    !is_nil(Users.get_user_by_username(username))
  end

  defp user_follower_count(username) do
    Users.get_follower_count(username)
  end
end
