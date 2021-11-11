defmodule TxConfirm.Requests do
  @token "YWTUP37V8FIJA7KN27H9TBESY7HJTUUAH9"
  @etherscan_base "https://api.etherscan.io/api"

  def most_recent_block do
    "#{@etherscan_base}?module=proxy&action=eth_blockNumber&apikey=#{@token}"
  end

  def get_most_recent_block do
    case HTTPoison.get(most_recent_block()) do
      {:ok, response} -> {:ok, response}
      _ -> {:error, "Failed to fetch block details"}
    end
  end
end