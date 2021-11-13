defmodule TxConfirmWeb.Api.V1.TransactionController do
  use TxConfirmWeb, :controller

  def check(conn, %{"params" => %{"tx_hash" => tx_hash}}) do
    res = TxConfirm.TxInfo.depth_info(tx_hash)
    status = res |> elem(0)
    result = res |> elem(1)
    # require IEx; IEx.pry
    json conn, %{ status: status, result: result }
  end
end
