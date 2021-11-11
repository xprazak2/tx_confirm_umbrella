defmodule TxConfirmWeb.Api.V1.TransactionController do
  use TxConfirmWeb, :controller

  def check(conn, %{"params" => %{"tx_hash" => tx_hash}}) do
    res = TxConfirm.TxInfo.depth_info(tx_hash)
    # require IEx; IEx.pry
    json conn, %{ result: res }
  end
end
