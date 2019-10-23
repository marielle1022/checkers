defmodule CheckersgameWeb.PageController do
  use CheckersgameWeb, :controller

  def index(conn, _params) do
    render(conn, "index.html")
  end

  def join(conn, %{"join" => %{"user" => user, "game" => game}}) do
    conn
    |> put_session(:user, user)
    |> put_session(:game, game)
    |> redirect(to: "/game/#{user}")
  end

  def game(conn) do
    user = get_session(conn, :user)
    game = get_session(conn, :game)

    if user do
      render(conn, "game.html", game: game, user: user)
    else
      conn
      |> put_flash(:error, "Must pick a username")
      |> redirect(to: "/")
    end
  end
end
