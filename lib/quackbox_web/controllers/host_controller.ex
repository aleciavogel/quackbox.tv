defmodule QuackboxWeb.HostController do
  use QuackboxWeb, :controller
  alias Quackbox.Games

  def index(conn, %{"room_access_code" => access_code}) do
    case Games.get_room!(access_code) do
      [room] ->
        conn
        |> render("index.html", room: room)
      [] ->
        conn
        |> put_flash(:error, "Something went wrong and room could not be found.")
        |> redirect(to: Routes.page_path(conn, :index))
      _ ->
        conn
        |> put_flash(:error, "Something went wrong and room could not be found.")
        |> redirect(to: Routes.page_path(conn, :index))
    end
  end
end
