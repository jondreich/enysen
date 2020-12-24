defmodule EnysenWeb.ChannelLive.Helpers do
  import Ecto.Query, warn: false
  use EnysenWeb, :live_view
  alias Enysen.Users

  def user_from_username(username) do
    Users.get_user_by_username(username)
  end
end
