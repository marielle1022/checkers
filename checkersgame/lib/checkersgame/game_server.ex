defmodule Checkersgame.GameServer do
  use GenServer

  alias Checkersgame.Game
  alias Checkersgame.Board

  # Need: client_view function; need to store state here, including board

  ## Client Interface
  def start_link(_args) do
    GenServer.start_link(__MODULE__, %{}, name: __MODULE__)
  end

  def view(game, user) do
    GenServer.call(__MODULE__, {:view, game, user})
  end

  def handle_call({:view, game, user}, _from, state) do
    gg = Map.get(state, game, Board.new())
    {:reply, Board.client_view(gg, user), Map.put(state, game, gg)}
  end
end
