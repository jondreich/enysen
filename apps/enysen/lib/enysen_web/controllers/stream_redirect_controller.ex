defmodule EnysenWeb.StreamRedirectController do
  use EnysenWeb, :controller
  alias Enysen.Content

  def start_stream(conn, params) do
    case Content.start_stream(%{key: params["name"]}) do
      {:ok, username} ->
        redirect(conn, external: "rtmp://127.0.0.1/dash/#{username}")
      {:error, error} ->
        IO.inspect(error)
        conn
        |> put_status(500)
        |> json(%{error: %{status: 500, message: "an internal server error has occurred, please try again later"}})
    end
  end

  def end_stream(conn, params) do
    case Content.end_stream(%{key: params["name"]}) do
      {1, nil} ->
        json(conn, %{success: %{message: "stream successfully ended"}})
      {0, nil} ->
        conn
        |> put_status(404)
        |> json(%{error: %{status: 404, message: "stream not ended, heck"}})
    end
  end
end
