defmodule QuackboxWeb.RoomController do
  use QuackboxWeb, :controller

  def create(conn, %{"room" => %{"game_id" => game_id, "max_players" => max_players}}) do
    room = Games.create_room(%{
      game_id: game_id,
      user_id: Pow.Plug.current_user(conn).id,
      max_players: max_players
    })

    conn
    |> redirect(to: Routes.room_host_path(conn, :index, room.access_code))
  end
end
