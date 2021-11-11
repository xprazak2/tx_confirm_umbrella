defmodule TxConfirm.TxInfo do
  @token "YWTUP37V8FIJA7KN27H9TBESY7HJTUUAH9"
  @etherscan_base "https://api.etherscan.io/api"

  alias TxConfirm.Requests

  def info(tx_hash) do
    # tx_hash |> get_tx_details
    get_most_recent_block()
  end

  def get_most_recent_block do
    case HTTPoison.get(most_recent_block()) do
      {:ok, response} -> parse_block_response(response)
      _ -> {:error, "Failed to fetch block details"}
    end
  end

  def parse_block_response(response) do
    case response.body |> Jason.decode do
      {:ok, json} -> result_value(json)
      _ -> {:error, "Failed to get the block details."}
    end
  end

  def get_tx_details(tx_hash) do
    case HTTPoison.get(tx_by_hash(tx_hash)) do
      {:ok, response } -> parse_tx_details_response(response)
      _ -> {:error, "Failed to get the transaction details"}
     end
  end

  def parse_tx_details_response(response) do
    case response.body |> Jason.decode do
      {:ok, json } -> result_value(json)
      _ -> {:error, "Failed to parse transaction details response" }
    end
  end

  def result_value(json) do
    if json |> Map.has_key?("result") do
      {:ok, json["result"]}
    else
      {:error, "Etherscan api failed to process the data request"}
    end
  end

  def block_num_decimal(block_hex) do
    block_hex |> String.slice(2..-1) |> Integer.parse(16) |> elem(0)
  end

  def tx_by_hash(tx_hash) do
    "#{@etherscan_base}?module=proxy&action=eth_getTransactionByHash&txhash=#{tx_hash}&apikey=#{@token}"
  end

  def most_recent_block do
    "#{@etherscan_base}?module=proxy&action=eth_blockNumber&apikey=#{@token}"
  end
end
