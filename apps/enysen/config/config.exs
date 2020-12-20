# This file is responsible for configuring your application
# and its dependencies with the aid of the Mix.Config module.
#
# This configuration file is loaded before any dependency and
# is restricted to this project.

# General application configuration
use Mix.Config

config :enysen,
  ecto_repos: [Enysen.Repo]

# Configures the endpoint
config :enysen, EnysenWeb.Endpoint,
  url: [host: "localhost"],
  secret_key_base: "mQxmkqKNOyGy2cDB7omg/wKSP4IhZv+k0vm4ZOmo+4otR2O3HSdw2VjCgR8EnAfU",
  render_errors: [view: EnysenWeb.ErrorView, accepts: ~w(html json), layout: false],
  pubsub_server: Enysen.PubSub,
  live_view: [signing_salt: "QS2OnIhV"]

# Configures Elixir's Logger
config :logger, :console,
  format: "$time $metadata[$level] $message\n",
  metadata: [:request_id]

# Use Jason for JSON parsing in Phoenix
config :phoenix, :json_library, Jason

# Pow for auth
config :enysen, :pow,
  user: Enysen.Users.User,
  repo: Enysen.Repo,
  web_module: EnysenWeb

# Import environment specific config. This must remain at the bottom
# of this file so it overrides the configuration defined above.
import_config "#{Mix.env()}.exs"
