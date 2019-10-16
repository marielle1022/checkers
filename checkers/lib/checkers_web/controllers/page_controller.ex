defmodule CheckersWeb.PageController do
  use CheckersWeb, :controller

  def index(conn, _params) do
    render(conn, "index.html")
  end
end
