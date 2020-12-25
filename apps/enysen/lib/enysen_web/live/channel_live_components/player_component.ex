defmodule EnysenWeb.ChannelLive.Player do
  import Ecto.Query, warn: false
  import EnysenWeb.ChannelLive.Helpers
  use EnysenWeb, :live_view

  @impl true
  def render(assigns) do
    ~L"""
    <video data-dashjs-player autoplay loop muted controls src="<%= @live_video_source %>" style="width: 630px;">
    </video>
    <div style="text-align: left;">
    <h2><%= gettext "%{name}'s stream", name: @username %></h2>
    <div>
      <h3 id="stream-title"><%= gettext "%{title}", title: @stream_title %></h3>
    </div>
    </div>
    """
  end

  @impl true
  def mount(_params, %{"username" => username, "live_video_source" => live_video_source, "current_user" => current_user, "edit_mode" => edit_mode}, socket) do
    {:ok, assign(
      socket,
      username: username,
      live_video_source: live_video_source,
      stream_title: user_from_username(username).stream_title,
      current_user: current_user,
      edit_mode: edit_mode)}
  end
end
