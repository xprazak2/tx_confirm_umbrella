defmodule TxConfirmWeb.Api.V1.TransactionController do
  use TxConfirmWeb, :controller

  def check(conn, %{"params" => %{"tx_hash" => tx_hash}}) do
    res = TxConfirm.TxInfo.info(tx_hash)
    # require IEx; IEx.pry
    json conn, %{ res: "ok"}
  end
end
