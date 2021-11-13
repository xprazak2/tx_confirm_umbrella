defmodule TxConfirm.TxInfoTest do
  use ExUnit.Case

  import Mox

  setup :verify_on_exit!

  @invalid_tx_hash "0x7b6d0e8d812873260291c3f8a9fa99a61721a033a01e5c5af3ceb5e1dc9e7bd0xy"
  @valid_tx_hash "0x7b6d0e8d812873260291c3f8a9fa99a61721a033a01e5c5af3ceb5e1dc9e7bd0"

  @last_block_hex "0xcfa21b"

  @last_block_ok {
    :ok,
    %HTTPoison.Response{
      body: "{\"jsonrpc\":\"2.0\",\"id\":83,\"result\":\"#{@last_block_hex}\"}\n"
    }
  }

  @tx_ok {
    :ok,
    %HTTPoison.Response{
      body: "{\"jsonrpc\":\"2.0\",\"id\":1,\"result\":{\"blockHash\":\"0xbaee22af41ce5cb4d28a6a377da26f4fc4f9d893fdfaa6878fb732f42367a947\",\"blockNumber\":\"0x4b9b05\",\"from\":\"0x0fe426d8f95510f4f0bac19be5e1252c4127ee00\",\"gas\":\"0x5208\",\"gasPrice\":\"0x4a817c800\",\"hash\":\"0x7b6d0e8d812873260291c3f8a9fa99a61721a033a01e5c5af3ceb5e1dc9e7bd0\",\"input\":\"0x\",\"nonce\":\"0x2\",\"to\":\"0x4848535892c8008b912d99aaf88772745a11c809\",\"transactionIndex\":\"0xa0\",\"value\":\"0x526e615a87b5000\",\"type\":\"0x0\",\"v\":\"0x25\",\"r\":\"0xb0a50a9b5e11e36e564d985f3590173a40f231a04c6bfd6132d87244b5b45bcb\",\"s\":\"0xa936a6f53d7e001a5f5ba6ca182e7e204a7ed0b8c5a7b874041a179d6e1e994\"}}\n"
    }
  }

  @tx_info %{
    "blockHash" => "0xbaee22af41ce5cb4d28a6a377da26f4fc4f9d893fdfaa6878fb732f42367a947",
    "blockNumber" => "0x4b9b05",
    "from" => "0x0fe426d8f95510f4f0bac19be5e1252c4127ee00",
    "gas" => "0x5208",
    "gasPrice" => "0x4a817c800",
    "hash" => "0x7b6d0e8d812873260291c3f8a9fa99a61721a033a01e5c5af3ceb5e1dc9e7bd0",
    "input" => "0x",
    "nonce" => "0x2",
    "r" => "0xb0a50a9b5e11e36e564d985f3590173a40f231a04c6bfd6132d87244b5b45bcb",
    "s" => "0xa936a6f53d7e001a5f5ba6ca182e7e204a7ed0b8c5a7b874041a179d6e1e994",
    "to" => "0x4848535892c8008b912d99aaf88772745a11c809",
    "transactionIndex" => "0xa0",
    "type" => "0x0",
    "v" => "0x25",
    "value" => "0x526e615a87b5000"
  }

  @tx_error_msg "invalid argument 0: hex string has length 66, want 64 for common.Hash"

  @tx_error {
    :ok,
    %HTTPoison.Response{
      body: "{\"jsonrpc\":\"2.0\",\"id\":1,\"error\":{\"code\":-32602,\"message\":\"#{@tx_error_msg}\"}}\n"
    }
  }

  test "should return last block" do
    TxConfirm.RequestsMock |> expect(:get_most_recent_block, fn -> @last_block_ok end)
    result = TxConfirm.TxInfo.last_block_num()
    assert {:ok, @last_block_hex} == result
  end

  test "should return transaction details" do
    TxConfirm.RequestsMock |> expect(:get_tx_details, fn _hash -> @tx_ok end)
    result = @valid_tx_hash |> TxConfirm.TxInfo.transaction
    assert {:ok, @tx_info} = result
  end

  test "should show transaction errors" do
    TxConfirm.RequestsMock |> expect(:get_tx_details, fn _hash -> @tx_error end)
    result = @invalid_tx_hash |> TxConfirm.TxInfo.transaction
    assert {:error, "Etherscan API error: #{@tx_error_msg}"} = result
  end

  test "should compare blocks" do
    result = TxConfirm.TxInfo.compare_blocks(@last_block_hex, @tx_info)
    assert {:ok, 8652566} == result
  end
end
