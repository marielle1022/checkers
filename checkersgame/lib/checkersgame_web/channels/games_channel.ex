defmodule CheckersgameWeb.GamesChannel do
  use CheckersgameWeb, :channel

  alias Checkersgame.GameServer
  alias Checkersgame.Game
  alias Checkersgame.BackupAgent

  # Citation: for structure and other information in many of the functions,
  # used hangman-2019-01 branch 2019-10-multiplayer-for-real

  intercept ["update"]

  # def join("games:" <> game, payload, socket) do
  #   if authorized?(payload) do
  #     socket = assign(socket, :game, game)
  #     view = GameServer.view(game, socket.assigns[:user])
  #     {:ok, %{"join" => game, "game" => view}, socket}
  #   else
  #     {:error, %{reason: "unauthorized"}}
  #   end
  # end

  def join("games:" <> name, payload, socket) do
    if authorized?(payload) do
      GameServer.start(name)
      game = GameServer.peek(name)
      BackupAgent.put(name, game)

      socket =
        socket
        |> assign(:name, name)

      {:ok, %{"join" => name, "game" => Game.client_view(game, name)}, socket}
    else
      {:error, %{reason: "unauthorized"}}
    end
  end

  # Channels can be used in a request/response fashion
  # by sending replies to requests from the client
  def handle_in("ping", payload, socket) do
    {:reply, {:ok, payload}, socket}
  end

  # It is also common to receive messages from the client and
  # broadcast to everyone in the current topic (games:lobby).
  def handle_in("shout", payload, socket) do
    broadcast(socket, "shout", payload)
    {:noreply, socket}
  end

  # Add authorization logic here as required.
  defp authorized?(_payload) do
    true
  end
end
