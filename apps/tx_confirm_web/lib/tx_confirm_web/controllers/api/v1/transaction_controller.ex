defmodule TxConfirmWeb.Api.V1.TransactionController do
  use TxConfirmWeb, :controller

  def check(conn, %{"params" => %{"tx_hash" => tx_hash}}) do
    res = TxConfirm.TxInfo.depth_info(tx_hash)
    json conn, %{ status: res |> elem(0), result: res |> elem(1) }
  end
end
