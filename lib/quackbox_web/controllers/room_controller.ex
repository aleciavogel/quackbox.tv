defmodule QuackboxWeb.RoomController do
  use QuackboxWeb, :controller
  alias Quackbox.Games

  def create(conn, %{"room" => %{"game_id" => game_id}}) do
    room = Games.create_room(%{
      game_id: game_id,
      user_id: Pow.Plug.current_user(conn).id
    })

    conn
    |> redirect(to: Routes.room_host_path(conn, :index, room.player_code))
  end

  def show(conn, _params) do
    # TODO
    render(conn, "show.html")
  end
end
