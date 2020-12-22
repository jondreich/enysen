defmodule EnysenWeb.LiveHelpers do
  import Phoenix.LiveView.Helpers

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
