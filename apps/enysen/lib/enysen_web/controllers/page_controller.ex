defmodule EnysenWeb.PageController do
  use EnysenWeb, :controller

  def index(conn, _params) do
    render(conn, "index.html")
  end

  def channel(conn, params) do
    # for the time being the live video source url must be assigned to host ip
    render(conn, "channel.html", username: params["username"], live_video_source: "http://192.168.1.224/dash/#{params["username"]}/index.mpd")
  end

  def profile(conn, params) do
    if Pow.Plug.current_user(conn) do
      render(conn, "profile.html", username: params["username"], signed_in: true)
    else
      render(conn, "profile.html", signed_in: false)
    end
  end
end
