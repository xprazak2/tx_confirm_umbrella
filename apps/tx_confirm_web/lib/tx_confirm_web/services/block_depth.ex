defmodule TxConfirmWeb.BlockDepth do
  @behaviour TxConfirmWeb.BlockDepthBehaviour

  def block_depth(tx_hash) do
    tx_hash |> TxConfirm.TxInfo.depth_info()
  end
end
