defmodule QuackboxWeb.RoomController do
  use QuackboxWeb, :controller
  alias Quackbox.Games
  alias Quackbox.Games.Room

  def create(conn, %{"room" => %{"game_id" => game_id, "max_players" => max_players}}) do
    attrs = %{
      game_id: game_id,
      user_id: Pow.Plug.current_user(conn).id,
      max_players: max_players
    }

    case Games.create_room(attrs) do
      {:ok, %Room{} = room} ->
        conn
        |> redirect(to: Routes.room_host_path(conn, :index, room.access_code))
      
      {:error, %Ecto.Changeset{} = changeset} ->
        conn
        |> put_view(QuackboxWeb.PageView)
        |> render("index.html", games: Games.list_games())
    end
  end
end
