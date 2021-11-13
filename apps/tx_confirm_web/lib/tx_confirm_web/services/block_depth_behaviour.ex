defmodule TxConfirmWeb.BlockDepthBehaviour do
  @callback block_depth(String.t()) :: tuple()
end
