use Mix.Config

config :tx_confirm,
  etherscan_api_key: "TestApiToken",
  requests_client: TxConfirm.RequestsMock

# Configure your database
#
# The MIX_TEST_PARTITION environment variable can be used
# to provide built-in test partitioning in CI environment.
# Run `mix help test` for more information.
config :tx_confirm, TxConfirm.Repo,
  username: "postgres",
  password: "postgres",
  database: "tx_confirm_test#{System.get_env("MIX_TEST_PARTITION")}",
  hostname: "localhost",
  pool: Ecto.Adapters.SQL.Sandbox

# We don't run a server during test. If one is required,
# you can enable the server option below.
config :tx_confirm_web, TxConfirmWeb.Endpoint,
  http: [port: 4002],
  server: false

# Print only warnings and errors during test
config :logger, level: :warn
