defmodule TxConfirmWeb.Api.V1.TransactionController do
  use TxConfirmWeb, :controller

  def check(conn, %{"params" => %{"tx_hash" => tx_hash}}) do
    res = tx_hash |> Application.get_env(:tx_confirm_web, :block_depth).block_depth
    json(conn, %{status: res |> elem(0), result: res |> elem(1)})
  end
end
