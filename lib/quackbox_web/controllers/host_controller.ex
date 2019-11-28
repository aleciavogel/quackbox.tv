defmodule QuackboxWeb.HostController do
  use QuackboxWeb, :controller
  
  alias Quackbox.Games

  def index(conn, %{"room_player_code" => player_code}) do
    room = Games.get_room!(player_code)
    
    render(conn, "index.html", room: room)
  end
end
