defmodule QuackboxWeb.RoomChannel.Audience do
  import Phoenix.Channel, only: [push: 3]

  alias Quackbox.Repo
  alias QuackboxWeb.Presence

  def join(access_code, audience_id, socket) do
    audience = 
      Repo.get(AudienceMember, audience_id)
      |> Repo.preload(:room)

    if audience.room.access_code === access_code do
      audience_info = %{
        name: audience.name,
        id: audience.id
      }
      send(self(), {:after_player_join, audience_info})
      {:ok, %{channel: "room:#{access_code}"}, socket}
    else
      {:error, %{reason: "Invalid session."}}
    end
  end
end
