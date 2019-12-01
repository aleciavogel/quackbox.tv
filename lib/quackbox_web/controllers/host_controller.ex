defmodule QuackboxWeb.HostController do
  use QuackboxWeb, :controller
  alias Quackbox.Games

  def index(conn, %{"room_access_code" => access_code}) do
    room = Games.get_room!(access_code)
    
    render(conn, "index.html", room: room)
  end
end
