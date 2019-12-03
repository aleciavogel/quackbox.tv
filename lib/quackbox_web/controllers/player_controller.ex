defmodule QuackboxWeb.PlayerController do
  use QuackboxWeb, :controller
  alias Quackbox.Games
  alias Quackbox.Games.{Player, AudienceMember}

  def create(conn, %{"player" => %{"name" => name, "access_code" => access_code}}) do
    attrs = %{name: name, access_code: String.upcase(access_code)}

    case Games.create_player_or_audience_member(attrs) do
      {:ok, %Player{} = player} ->
        token = Phoenix.Token.sign(conn, "player token", player.id)
        conn
        |> put_session(:player_token, token)
        |> redirect(to: Routes.room_play_path(conn, :show, access_code))
      
      {:ok, %AudienceMember{} = audience_member} ->
        token = Phoenix.Token.sign(conn, "audience token", audience_member.id)
        conn
        |> put_session(:audience_token, token)
        |> redirect(to: Routes.room_watch_path(conn, :show, access_code))

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
  
  def show(conn, %{"room_access_code" => access_code}) do
    player_token = get_session(conn, :player_token)

    conn
    |> put_layout({QuackboxWeb.LayoutView, "player.html"})
    |> render("show.html", player_token: player_token, access_code: access_code)
  end
end
