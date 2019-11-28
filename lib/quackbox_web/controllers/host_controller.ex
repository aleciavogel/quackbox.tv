defmodule QuackboxWeb.HostController do
  use QuackboxWeb, :controller

  def index(conn, _params) do
    render(conn, "index.html")
  end
end
