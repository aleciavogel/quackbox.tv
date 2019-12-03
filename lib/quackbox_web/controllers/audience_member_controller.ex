defmodule QuackboxWeb.AudienceMemberController do
  use QuackboxWeb, :controller
  alias Quackbox.Games

  def show(conn, _params) do
    audience_token = get_session(conn, :audience_token)

    conn
    |> put_layout({QuackboxWeb.LayoutView, "audience.html"})
    |> render("show.html", audience_token: audience_token)
  end
end