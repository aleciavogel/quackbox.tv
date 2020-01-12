defmodule QuackboxWeb.RoomChannel.Host do
  import Ecto.Query, warn: false
  import Phoenix.Socket, only: [assign: 3]

  alias Quackbox.Repo
  alias Quackbox.Games
  alias Quackbox.Games.Room
  alias QuackboxWeb.Presence

  def join(access_code, socket) do
    case Games.get_room!(access_code) do
      [%Room{} = room] ->
        response = %{
          scene: room.current_scene,
          presences: Presence.list(socket),
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

  # Determine the current chooser from the room state
  defp fetch_chooser(%Room{} = room) do
    if room.players |> Enum.empty? do
      nil
    else
      case room.chooser_id do
        nil -> set_chooser(room)

        _chooser_id -> 
          chooser = Games.get_room_chooser!(room.chooser_id)
          %{
            name: chooser.name,
            id: chooser.id
          }
      end
    end
  end

  # Set the room's current chooser
  defp set_chooser(%Room{} = room) do
    if room.current_scene == "category-select" do
      chooser = Games.get_random_room_player!(room.id)

      room
      |> Room.changeset(%{chooser_id: chooser.id})
      |> Repo.update

      %{
        name: chooser.name,
        id: chooser.id
      }
    else
      nil
    end
  end
end
