defmodule Enysen.Repo do
  use Ecto.Repo,
    otp_app: :enysen,
    adapter: Ecto.Adapters.Postgres
end
