defmodule Checkersgame.GameSup do
  use DynamicSupervisor

  # Assuming this is nearly a template, referencing
  # it from the hangman backup_agent.ex file

  def start_link(arg) do
    DynamicSupervisor.start_link(__MODULE__, arg, name: __MODULE__)
  end

  @impl true
  def init(_arg) do
    {:ok, _} = Registry.start_link(keys: :unique, name: Checkersgame.GameReg)
    DynamicSupervisor.init(strategy: :one_for_one)
  end

  def start_child(spec) do
    DynamicSupervisor.start_child(__MODULE__, spec)
  end
end
