defmodule TxConfirm.Repo do
  use Ecto.Repo,
    otp_app: :tx_confirm,
    adapter: Ecto.Adapters.Postgres
end
