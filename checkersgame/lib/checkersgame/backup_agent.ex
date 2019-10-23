defmodule Checkersgame.BackupAgent do
  use Agent

  # This is basically just a global mutable map.
  # Using this from the hangman backup_agent.ex file

  # NB: use __MODULE__ so that if name of module (Checkersgame.BackupAgent) is changed,
  # don't need to change name everywhere

  def start_link(_args) do
    Agent.start_link(fn -> %{} end, name: __MODULE__)
  end

  def put(name, val) do
    Agent.update(__MODULE__, fn state ->
      Map.put(state, name, val)
    end)
  end

  # TODO: add in timestamp to cause game to time out after disuse
  def get(name) do
    Agent.get(__MODULE__, fn state ->
      Map.get(state, name)
    end)
  end
end
