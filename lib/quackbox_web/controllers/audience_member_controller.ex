defmodule QuackboxWeb.AudienceMemberController do
  use QuackboxWeb, :controller
  alias Quackbox.Games

  def show(conn, %{"token" => token}) do
    audience = Games.get_audience_member!(token)

    conn
    |> put_layout({LayoutView, "audience.html"})
    |> render("show.html", audience_member: audience)
  end
end