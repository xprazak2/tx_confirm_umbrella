defmodule TxConfirm.TxInfo do
  alias TxConfirm.Requests

  def depth_info(tx_hash) do
    with {:ok, last_block} <- last_block_num(),
         {:ok, tx} <- transaction(tx_hash)
    do
      compare_blocks(last_block, tx)
    end
  end

  def last_block_num() do
    Requests.get_most_recent_block() |> parse_response |> result_value
  end

  def transaction(tx_hash) do
    tx_hash |> Requests.get_tx_details |> parse_response |> result_value
  end

  def compare_blocks(last_block, tx) do
    {:ok, block_num_decimal(last_block) - block_num_decimal(tx["blockNumber"]) }
  end

  def parse_response({:ok, response}) do
    response.body |> Jason.decode
  end
  def parse_response(err) do
    {:error, "Failed to parse response from Etherscan API."}
  end

  def result_value({:ok, json}) do
    cond do
      json |> Map.has_key?("message") && json["message"] == "NOTOK" ->
        {:error, json["result"] |> etherscan_error}
      json |> Map.has_key?("error") ->
        {:error, json["error"]["message"] |> etherscan_error }
      true ->
        {:ok, json["result"]}
    end
  end
  def result_value(error) do
    error
  end

  def block_num_decimal(block_hex) do
    block_hex |> String.slice(2..-1) |> Integer.parse(16) |> elem(0)
  end

  defp etherscan_error(msg) do
    "Etherscan API error: #{msg}"
  end
end
