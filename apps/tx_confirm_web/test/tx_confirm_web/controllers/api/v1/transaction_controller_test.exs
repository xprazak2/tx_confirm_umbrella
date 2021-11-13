defmodule TxConfirmWeb.Api.V1.TransactionControllerTest do
  use TxConfirmWeb.ConnCase

  import Mox

  test "POST /transactions/check", %{conn: conn} do
    TxConfirmWeb.BlockDepthMock |> expect(:block_depth, fn _ -> {:ok, 10} end)
    conn = post(conn, "/api/v1/transactions/check", %{"params" => %{"tx_hash" => "abc"}})
    assert %{"result" => 10, "status" => "ok"} == json_response(conn, 200)
  end
end
