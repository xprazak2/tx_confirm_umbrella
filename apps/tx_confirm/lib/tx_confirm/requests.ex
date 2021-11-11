defmodule TxConfirm.Requests do
  @token "YWTUP37V8FIJA7KN27H9TBESY7HJTUUAH9"
  @etherscan_base "https://api.etherscan.io/api"

  def most_recent_block do
    "#{@etherscan_base}?module=proxy&action=eth_blockNumber&apikey=#{@token}"
  end

  def tx_by_hash(tx_hash) do
    "#{@etherscan_base}?module=proxy&action=eth_getTransactionByHash&txhash=#{tx_hash}&apikey=#{@token}"
  end

  def get_most_recent_block do
    case HTTPoison.get(most_recent_block()) do
      {:ok, response} -> {:ok, response}
      _ -> {:error, "Failed to fetch block details"}
    end
  end

  def get_tx_details(tx_hash) do
    case HTTPoison.get(tx_by_hash(tx_hash)) do
      {:ok, response } -> {:ok, response}
      _ -> {:error, "Failed to get the transaction details"}
    end
  end
end
