defmodule TxConfirm.TxInfo do
  alias TxConfirm.Requests

  def depth_info(tx_hash) do
    maybe_last_block = Requests.get_most_recent_block() |> parse_response |> result_value
    maybe_tx = tx_hash |> Requests.get_tx_details |> parse_response |> result_value
    res = compare_blocks(maybe_last_block, maybe_tx)
    require IEx; IEx.pry
  end

  def compare_blocks({:error, msg}, res) do
    {:error, msg}
  end
  def compare_blocks(res, {:error, msg}) do
    {:error, msg}
  end
  def compare_blocks({:ok, last_block}, {:ok, tx}) do
    block_num_decimal(last_block) - block_num_decimal(tx["blockNumber"])
  end

  def parse_response({:ok, response}) do
    response.body |> Jason.decode
  end
  def parse_response(_) do
    {:error, "Failed to parse response from Etherscan API."}
  end

  def result_value({:ok, json}) do
    if json |> Map.has_key?("result") do
      {:ok, json["result"]}
    else
      {:error, "Etherscan api failed to process the data request"}
    end
  end
  def result_value(error) do
    error
  end

  def block_num_decimal(block_hex) do
    block_hex |> String.slice(2..-1) |> Integer.parse(16) |> elem(0)
  end
end
