defmodule QuackboxWeb.AudienceMemberController do
  use QuackboxWeb, :controller

  def show(conn, %{"room_access_code" => access_code}) do
    audience_token = get_session(conn, :audience_token)

    conn
    |> put_layout({QuackboxWeb.LayoutView, "audience.html"})
    |> render("show.html", audience_token: audience_token, access_code: access_code)
  end
end
