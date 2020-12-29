defmodule EnysenWeb.DashboardLive do
  use Surface.LiveView
  use Surface.Component
  alias Surface.Components.Form
  alias Surface.Components.Form.Field
  alias Surface.Components.Form.TextInput
  alias Surface.Components.Form.TextArea
  alias Surface.Components.Form.Submit
  alias EnysenWeb.LiveHelpers
  alias Enysen.Users
  alias Enysen.Users.Channel

  @impl true
  def mount(_params, session, socket) do
    case LiveHelpers.get_user(socket, session) do
      nil ->
        {:ok, socket
        |> redirect(to: "/session/new")}
      user ->
        {:ok, assign(
          socket,
          current_user: user,
          channel: get_channel(user.username),
          submit: "update_channel")}
    end
  end

  defp get_channel(username) do
    case Users.get_channel(username) do
      nil ->
        nil
      channel ->
        channel
    end
  end

  @impl true
  def handle_event("generate_channel", _params, socket) do
    case Users.create_channel(%{user: socket.assigns.current_user}) do
      {:ok, _} ->
        {:noreply, socket}
      {:error, _} ->
        {:noreply,
        socket
        |> put_flash(:error, "OOPSIE WOOPSIE!! Uwu We made a fucky wucky!! A wittle fucko boingo! The code monkeys at our headquarters are working VEWY HAWD to fix this!")}
    end
  end

  @impl true
  def handle_event("update_channel", %{"Elixir.Enysen.Users.Channel" => %{"stream_title" => stream_title, "bio" => bio}}, socket) do
    case Users.update_channel(get_channel(socket.assigns.current_user.username), %{stream_title: stream_title, bio: bio}) do
      {:ok, %Channel{}} ->
        {:noreply,
        socket
        |> put_flash(:info, "Updated")}
      {:error, _} ->
        {:noreply,
        socket
        |> put_flash(:error, "OOPSIE WOOPSIE!! Uwu We made a fucky wucky!! A wittle fucko boingo! The code monkeys at our headquarters are working VEWY HAWD to fix this!")}
    end
  end
end
