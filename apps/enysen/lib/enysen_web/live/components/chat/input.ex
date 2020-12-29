defmodule EnysenWeb.Live.Components.Chat.Input do
  use Surface.Component
  alias Surface.Components.Form
  alias Surface.Components.Form.Field
  alias Surface.Components.Form.TextArea
  alias Surface.Components.Form.Submit
  alias Enysen.Chats.ChatMessage

  prop submit, :event, required: true

  def render(assigns) do
    ~H"""
    <Form for={{ ChatMessage }} submit={{ @submit }} action="#">
      <Field name="body">
        <TextArea opts={{ placeholder: "Type message here..." }} />
      </Field>
      <Submit>send</Submit>
    </Form>
    """
  end
end
