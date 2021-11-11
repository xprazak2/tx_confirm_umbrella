# This file is responsible for configuring your umbrella
# and **all applications** and their dependencies with the
# help of Mix.Config.
#
# Note that all applications in your umbrella share the
# same configuration and dependencies, which is why they
# all use the same configuration file. If you want different
# configurations or dependencies per app, it is best to
# move said applications out of the umbrella.
use Mix.Config

# Configure Mix tasks and generators
config :tx_confirm,
  ecto_repos: [TxConfirm.Repo]

config :tx_confirm_web,
  ecto_repos: [TxConfirm.Repo],
  generators: [context_app: :tx_confirm]

# Configures the endpoint
config :tx_confirm_web, TxConfirmWeb.Endpoint,
  url: [host: "localhost"],
  secret_key_base: "MJwza6t8F9c2gibfqoFqDVtHTIjQ9+pfb+KS6QY9Ybt4ATmPnAXajL5jbFvCQkKK",
  render_errors: [view: TxConfirmWeb.ErrorView, accepts: ~w(html json), layout: false],
  pubsub_server: TxConfirm.PubSub,
  live_view: [signing_salt: "MZrjoRPL"]

# Configures Elixir's Logger
config :logger, :console,
  format: "$time $metadata[$level] $message\n",
  metadata: [:request_id]

# Use Jason for JSON parsing in Phoenix
config :phoenix, :json_library, Jason

# Import environment specific config. This must remain at the bottom
# of this file so it overrides the configuration defined above.
import_config "#{Mix.env()}.exs"
