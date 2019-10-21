defmodule CheckersgameWeb.Router do
  use CheckersgameWeb, :router

  pipeline :browser do
    plug :accepts, ["html"]
    plug :fetch_session
    plug :fetch_flash
    plug :protect_from_forgery
    plug :put_secure_browser_headers
    plug MyAuth
    plug :put_user_token
  end
    //
  defp put_user_token(conn, _) do
    if current_user = conn.assigns[:current_user] do
      token = Phoenix.Token.sign(conn, "user socket", current_user.id)
      assign(conn, :user_token, token)
    else
      conn
    end
  end

  pipeline :api do
    plug :accepts, ["json"]
  end

  scope "/", CheckersgameWeb do
    pipe_through :browser

    get "/", PageController, :index
    post "/join", PageController, :join
    get "/game/:name", PageController, :game

  end

  

  # Other scopes may use custom stacks.
  # scope "/api", CheckersgameWeb do
  #   pipe_through :api
  # end
end
