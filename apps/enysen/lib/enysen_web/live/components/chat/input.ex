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
      <div class="field">
        <Field name="body">
          <TextArea opts={{ placeholder: "Type message here...", class: "textarea has-fixed-size" }} />
        </Field>
      </div>
      <div class="field has-text-right">
        <Submit opts={{ class: "button is-primary is-small" }}>SEND</Submit>
      </div>
    </Form>
    """
  end
end
