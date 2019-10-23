defmodule Checkersgame.GameServer do
  use GenServer

  alias Checkersgame.Game

  # Need: client_view function; need to store state here, including board

  # Citation: for structure and other information in many of the functions,
  # used hangman-2019-01 branch 2019-10-multiplayer-for-real
  ## Client Interface
  def start_link(_args) do
    GenServer.start_link(__MODULE__, %{}, name: __MODULE__)
  end

  def view(game, user) do
    GenServer.call(__MODULE__, {:view, game, user})
  end

  def handle_call({:view, game, user}, _from, state) do
    gg = Map.get(state, game, Game.new())
    {:reply, Game.client_view(gg, user), Map.put(state, game, gg)}
  end
end
