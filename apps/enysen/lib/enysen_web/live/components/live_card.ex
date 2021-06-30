defmodule EnysenWeb.Live.Components.LiveCard do
  use Surface.Component

  prop username, :string, required: true
  prop stream_title, :string
  prop class, :string

  def render(assigns) do
    ~H"""
    <div class="card">
      <div class="card-content">
        <div class="media">
          <div class="media-left">
            <figure class="image is-64x64">
              <img src="https://bulma.io/images/placeholders/64x64.png" class="is-rounded">
            </figure>
          </div>
          <div class="media-content">
            <p class="title is-4">{{ @username }}</p>
            <p class="subtitle is-5">{{ @stream_title }}</p>
          </div>
        </div>
      </div>
    </div>
    """
  end
end
