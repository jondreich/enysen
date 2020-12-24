defmodule EnysenWeb.ChannelLive.FollowButton do
  import Ecto.Query, warn: false
  import EnysenWeb.ChannelLive.Helpers
  use EnysenWeb, :live_view
  alias Enysen.Users

  @impl true
  def render(assigns) do
    ~L"""
    <b><%= gettext "followers: %{follower_count}", follower_count: @follower_count %></b>
    <button phx-click="follow_unfollow">
    <%= gettext "%{action_text}", action_text: @action_text, channel_owner: @channel_owner, current_user_id: @current_user_id %>
    </button>
    """
  end

  @impl true
  def mount(_params, %{"channel_owner" => channel_owner, "current_user_id" => current_user_id}, socket) do
    {:ok, assign(
      socket,
      action_text: follow_button_text(current_user_id, Users.get_user_by_username(channel_owner).id),
      channel_owner: channel_owner,
      current_user_id: current_user_id,
      follower_count: user_follower_count(channel_owner)
      )}
  end

  @impl true
  def handle_event("follow_unfollow", _params, socket) do
    if !is_nil(socket.assigns.current_user_id) do
      case socket.assigns.action_text do
        "follow" ->
          case Users.follow(%{follower_id: socket.assigns.current_user_id, user_id: user_from_username(socket.assigns.channel_owner).id}) do
            {:ok, %Users.Follower{}} ->
              {:noreply, assign(socket, [action_text: "unfollow", follower_count: socket.assigns.follower_count + 1])}
            {:error, _} ->
              {:noreply,
              socket
              |> put_flash(:error, "OOPSIE WOOPSIE!! Uwu We made a fucky wucky!! A wittle fucko boingo! The code monkeys at our headquarters are working VEWY HAWD to fix this!")}
          end
        "unfollow" ->
          case Users.unfollow(%{follower_id: socket.assigns.current_user_id, user_id: user_from_username(socket.assigns.channel_owner).id}) do
            {:ok, {1, nil}} ->
              {:noreply, assign(socket, [action_text: "follow", follower_count: socket.assigns.follower_count - 1])}
            {:ok, {0, nil}} ->
              {:noreply,
              socket
              |> put_flash(:error, "OOPSIE WOOPSIE!! Uwu We made a fucky wucky!! A wittle fucko boingo! The code monkeys at our headquarters are working VEWY HAWD to fix this!")}
          end
      end
    else
      {:noreply,
      socket
      |> put_flash(:info, "log in first bitch")}
    end
  end

  defp follow_button_text(follower_id, user_id) do
    if is_nil(user_id) || is_nil(follower_id) do
      "follow"
    else
      case Users.check_following(%{follower_id: follower_id, user_id: user_id}) do
        true -> "unfollow"
        false -> "follow"
      end
    end
  end

  defp user_follower_count(username) do
    Users.get_follower_count(username)
  end
end
