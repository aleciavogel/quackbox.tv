defmodule QuackboxWeb.RoomChannel.Host do
  import Ecto.Query, warn: false
  import Phoenix.Socket, only: [assign: 3]

  alias Quackbox.Games
  alias Quackbox.Games.Room
  alias QuackboxWeb.Presence

  def join(access_code, socket) do
    case Games.get_room!(access_code) do
      [%Room{} = room] ->
        presences = Presence.list(socket)
        response = %{
          scene: room.current_scene,
          presences: presences,
          chooser: fetch_chooser(room),
          categories: room.category_choices
        }
        {:ok, response, assign(socket, :room_id, room.id)}
      [] ->
        {:error, %{reason: "Invalid room"}}
      _ ->
        {:error, %{reason: "Invalid room"}}
    end
  end
end
