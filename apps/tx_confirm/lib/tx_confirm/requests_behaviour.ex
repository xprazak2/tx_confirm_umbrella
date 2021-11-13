defmodule TxConfirm.RequestsBehaviour do
  @callback get_most_recent_block() :: tuple()
  @callback get_tx_details(String.t()) :: tuple()
end
