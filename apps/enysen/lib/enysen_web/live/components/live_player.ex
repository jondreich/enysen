defmodule EnysenWeb.Live.Components.LivePlayer do
  use Surface.Component

  prop username, :string, required: true
  prop class, :string

  def render(assigns) do
    ~H"""
    <video data-dashjs-player autoplay loop muted controls src={{ "http://192.168.1.224:8080/dash/#{@username}/index.mpd" }} class={{ @class }} >
    </video>
    """
  end
end
