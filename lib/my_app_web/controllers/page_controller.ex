defmodule MyAppWeb.PageController do
  use MyAppWeb, :controller

  def index(conn, _params) do
    render(conn, "index.html")
  end

  def client(conn, _params) do
    render(conn, "client.html")
  end
end
