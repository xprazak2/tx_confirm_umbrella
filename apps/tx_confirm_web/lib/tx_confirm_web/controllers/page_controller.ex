defmodule TxConfirmWeb.PageController do
  use TxConfirmWeb, :controller

  def index(conn, _params) do
    render(conn, "index.html")
  end
end
