defmodule QuackboxWeb.PlayerController do
  use QuackboxWeb, :controller
  alias Quackbox.Games
  alias Quackbox.Games.{Player, AudienceMember}

  def create(conn, %{"player" => %{"name" => name, "access_code" => access_code}}) do
    attrs = %{name: name, access_code: String.upcase(access_code)}

    case Games.create_player_or_audience_member(attrs) do
      {:ok, %Player{} = player} ->
        conn
        |> redirect(to: Routes.room_play_path(conn, :show, access_code, player.token))
      
      {:ok, %AudienceMember{} = audience_member} ->
        conn
        |> redirect(to: Routes.room_watch_path(conn, :show, access_code, audience_member.token))

      {:error, %Ecto.Changeset{} = changeset} ->
        conn
        |> put_view(QuackboxWeb.PageView)
        |> render("index.html", games: Games.list_games(), player_changeset: changeset, room_changeset: Games.new_room())
      
      nil ->
        conn
        |> put_flash(:error, "Something has gone wrong and player could not be created.")
        |> redirect(to: Routes.page_path(conn, :index))
    end
  end
  
  def show(conn, %{"token" => player_token}) do
    player = Games.get_player!(player_token)
    render(conn, "show.html", player: player)
  end
end
