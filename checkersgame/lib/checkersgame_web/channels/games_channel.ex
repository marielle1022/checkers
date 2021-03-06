defmodule CheckersgameWeb.GamesChannel do
  use CheckersgameWeb, :channel

  alias Checkersgame.Game
  alias Checkersgame.BackupAgent

  # Citation: for structure and other information in many of the functions,
  # used hangman-2019-01 branch 2019-10-multiplayer-for-real

  # intercept ["update"]

  def join("games:" <> name, payload, socket) do
    if authorized?(payload) do
      game = BackupAgent.get(name) || Game.new()

      socket =
        socket
        |> assign(:game, game)
        |> assign(:name, name)

      BackupAgent.put(name, game)
      IO.inspect(socket)
      {:ok, %{"join" => name, "game" => Game.client_view(game)}, socket}
    else
      {:error, %{reason: "unauthorized"}}
    end
  end

  def handle_in("click", %{"click" => ll}, socket) do
    name = socket.assigns[:name]
    game = BackupAgent.get(name)

    case Game.click(socket.assigns[:game], ll) do
      :ok ->
        socket = assign(socket, :game, game)
        BackupAgent.put(name, game)
        broadcast!(socket, "update", %{"game" => Game.client_view(game)})
        {:reply, {:ok, %{"game" => Game.client_view(game)}}, socket}

      game ->
        socket = assign(socket, :game, game)
        BackupAgent.put(name, game)
        broadcast!(socket, "update", %{"game" => Game.client_view(game)})
        {:reply, {:ok, %{"game" => Game.client_view(game)}}, socket}
    end
  end

  # # Channels can be used in a request/response fashion
  # # by sending replies to requests from the client
  # def handle_in("ping", payload, socket) do
  #   {:reply, {:ok, payload}, socket}
  # end
  #
  # # Structure of function referenced from hangman 2019-10 multiplayer
  # def handle_in("click", %{"move" => ll}, socket) do
  #   name = socket.assigns[:name]
  #
  #   # TODO change server "guess()" call to match checkers
  #   game = GameServer.guess(name, ll)
  #   broadcast!(socket, "update", %{"game" => Game.client_view(game)})
  #   {:reply, {:ok, %{"game" => Game.client_view(game)}}, socket}
  # end
  #
  # # It is also common to receive messages from the client and
  # # broadcast to everyone in the current topic (games:lobby).
  # def handle_in("shout", payload, socket) do
  #   broadcast(socket, "shout", payload)
  #   {:noreply, socket}
  # end

  # Add authorization logic here as required.
  defp authorized?(_payload) do
    true
  end
end
