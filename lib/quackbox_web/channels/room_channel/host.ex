defmodule QuackboxWeb.RoomChannel.Host do
  import Ecto.Query, warn: false
  import Phoenix.Socket, only: [assign: 3]

  alias Quackbox.Games
  alias Quackbox.Games.Room
  alias QuackboxWeb.Presence

  def join(access_code, socket) do
    case Games.get_room!(access_code) do
      [%Room{} = room] ->
        response = %{
          scene: room.current_scene,
          presences: Presence.list(socket)
        }
        {:ok, response, assign(socket, :room_id, room.id)}
      [] ->
        {:error, %{reason: "Invalid room"}}
      _ ->
        {:error, %{reason: "Invalid room"}}
    end
  end
end
