defmodule QuackboxWeb.PlayerController do
  use QuackboxWeb, :controller
  alias Quackbox.Games

  def create(conn, %{"player" => %{"name" => name, "access_code" => access_code}}) do
    attrs = %{name: name, access_code: access_code}

    case Games.create_player(attrs) do
      {:ok, player} ->
        conn
        |> redirect(to: Routes.room_play_path(conn, :show, access_code, player.token))
      {:error, changeset} ->
        conn
        |> redirect(to: Routes.page_path(conn, :index)) # TODO: add a specific changeset to render error
      
    end
  end
  
  def show(conn, %{"token" => player_token}) do
    player = Games.get_player!(player_token)
    render(conn, "show.html", player: player)
  end
end