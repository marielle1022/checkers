defmodule Checkersgame.GameServer do
  use GenServer

  alias Checkersgame.Game

  # Need: client_view function; need to store state here, including board

  # Citation: for structure and other information in many of the functions,
  # used hangman-2019-01 branch 2019-10-multiplayer-for-real

  def start(name) do
    spec = %{
      id: __MODULE__,
      start: {__MODULE__, :start_link, [name]},
      restart: :permanent,
      type: :worker
    }

    Checkersgame.GameSup.start_child(spec)
  end

  ## Client Interface
  def start_link(_args) do
    game = Checkersgame.BackupAgent.get(name) || Checkersgame.Game.new()
    GenServer.start_link(__MODULE__, game, name: reg(name))
  end

  def view(game, user) do
    GenServer.call(__MODULE__, {:view, game, user})
  end

  def handle_call({:view, game, user}, _from, state) do
    gg = Map.get(state, game, Game.new())
    {:reply, Game.client_view(gg, user), Map.put(state, game, gg)}
  end
end
