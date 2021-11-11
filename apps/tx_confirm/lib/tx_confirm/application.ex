defmodule TxConfirm.Application do
  # See https://hexdocs.pm/elixir/Application.html
  # for more information on OTP Applications
  @moduledoc false

  use Application

  def start(_type, _args) do
    children = [
      # Start the Ecto repository
      TxConfirm.Repo,
      # Start the PubSub system
      {Phoenix.PubSub, name: TxConfirm.PubSub}
      # Start a worker by calling: TxConfirm.Worker.start_link(arg)
      # {TxConfirm.Worker, arg}
    ]

    Supervisor.start_link(children, strategy: :one_for_one, name: TxConfirm.Supervisor)
  end
end
