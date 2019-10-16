defmodule CheckersgameWeb.PageController do
  use CheckersgameWeb, :controller

  def index(conn, _params) do
    render(conn, "index.html")
  end
end
