defmodule QuackboxWeb.PageController do
  use QuackboxWeb, :controller
  alias Quackbox.Games
  alias Quackbox.Games.Room

  def index(conn, _params) do
    games = Games.list_games()

    render(conn, "index.html", games: games)
  end
end
