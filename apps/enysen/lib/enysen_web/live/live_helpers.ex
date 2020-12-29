defmodule EnysenWeb.LiveHelpers do
  import Phoenix.LiveView.Helpers
  alias Enysen.Users.User
  alias Phoenix.LiveView.Socket
  alias Pow.Store.CredentialsCache

  @spec get_user(socket :: Socket.t(), session :: map(), config :: keyword()) :: %User{} | nil
  def get_user(socket, session, config \\ [otp_app: :myapp])

  def get_user(socket, %{"enysen_auth" => signed_token}, config) do
    conn = struct!(Plug.Conn, secret_key_base: socket.endpoint.config(:secret_key_base))
    salt = Atom.to_string(Pow.Plug.Session)

    with {:ok, token} <- Pow.Plug.verify_token(conn, salt, signed_token, config),
         {user, _metadata} <- CredentialsCache.get([backend: Pow.Store.Backend.EtsCache], token) do
      user
    else
      _any -> nil
    end
  end

  def get_user(_, _, _), do: nil

  @doc """
  Renders a component inside the `EnysenWeb.ModalComponent` component.

  The rendered modal receives a `:return_to` option to properly update
  the URL when the modal is closed.

  ## Examples

      <%= live_modal @socket, EnysenWeb.ChannelChatLive.FormComponent,
        id: @channel_chat.id || :new,
        action: @live_action,
        channel_chat: @channel_chat,
        return_to: Routes.channel_chat_index_path(@socket, :index) %>
  """
  def live_modal(socket, component, opts) do
    path = Keyword.fetch!(opts, :return_to)
    modal_opts = [id: :modal, return_to: path, component: component, opts: opts]
    live_component(socket, EnysenWeb.ModalComponent, modal_opts)
  end
end
