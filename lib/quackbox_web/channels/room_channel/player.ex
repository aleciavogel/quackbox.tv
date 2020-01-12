defmodule QuackboxWeb.RoomChannel.Player do
  import Phoenix.Channel, only: [push: 3, broadcast!: 3]
  import Phoenix.Socket, only: [assign: 3]

  alias Quackbox.Repo
  alias Quackbox.Games.{Player}
  alias QuackboxWeb.Presence

  def join(access_code, player_id, socket) do
    player = 
      Repo.get(Player, player_id)
      |> Repo.preload(:room)

    if player.room.access_code === access_code do
      player_info = %{
        name: player.name,
        id: player.id,
        is_lead: Presence.list(socket) |> Enum.empty?
      }
      response = %{
        player: player_info,
        scene: player.room.current_scene
      }
      send(self(), {:after_player_join, player_info})
      {:ok, response, assign(socket, :room_id, player.room.id)}
    else
      {:error, %{reason: "Invalid session."}}
    end
  end
end
