defmodule QuackboxWeb.AudienceMemberController do
  use QuackboxWeb, :controller
  alias Quackbox.Games

  def show(conn, _params) do
    conn
    |> put_layout({QuackboxWeb.LayoutView, "audience.html"})
    |> render("show.html")
  end
end