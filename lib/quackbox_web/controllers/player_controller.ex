defmodule QuackboxWeb.PlayerController do
  use QuackboxWeb, :controller
  alias Quackbox.Games

  def create(conn, %{"player" => %{"name" => name, "player_code" => player_code}}) do
    attrs = %{name: name, player_code: player_code}

    case Games.create_player(attrs) do
      player ->
        conn
        |> redirect(to: Routes.room_play_path(conn, :show, player_code, player.token))
      nil ->
        conn
        |> redirect(to: Routes.page_path(conn, :index)) # TODO: add a specific changeset to render error
    end
  end

  def show(conn, %{"token" => player_token}) do
    player = Games.get_player!(player_token)
    render(conn, "show.html", player: player)
  end
end
