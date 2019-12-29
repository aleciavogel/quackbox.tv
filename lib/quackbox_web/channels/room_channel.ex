defmodule QuackboxWeb.RoomChannel do
  use QuackboxWeb, :channel
  alias Quackbox.Repo
  alias Quackbox.Games
  alias Quackbox.Games.{Player, AudienceMember, Room}

  def join("room:" <> access_code, _params, socket) do
    player_id = socket.assigns[:current_player_id]
    audience_id = socket.assigns[:current_audience_id]
    host_id = socket.assigns[:current_host_id]

    cond do
      player_id != nil ->
        player = 
          Repo.get(Player, player_id)
          |> Repo.preload(:room)
        if player.room.access_code === access_code do
          player_info = %{
            name: player.name,
            id: player.id
          }
          send(self, {:after_player_join, player_info})
          {:ok, %{channel: "room:#{access_code}"}, socket}
        else
          {:error, %{reason: "Invalid session."}}
        end

      audience_id != nil ->
        audience = 
          Repo.get(AudienceMember, audience_id)
          |> Repo.preload(:room)
        if audience.room.access_code === access_code do
          audience_info = %{
            name: audience.name,
            id: audience.id
          }
          send(self, {:after_player_join, audience_info})
          {:ok, %{channel: "room:#{access_code}"}, socket}
        else
          {:error, %{reason: "Invalid session."}}
        end
      
      host_id != nil ->
        {:ok, %{channel: "room:#{access_code}"}, socket}

      true ->
        {:error, %{reason: "Invalid session."}}
    end
  end

  def handle_info({:after_player_join, player}, socket) do
    broadcast!(socket, "player:joined", player)
    {:noreply, socket}
  end

  def handle_info({:after_audience_join, audience}, socket) do
    broadcast!(socket, "audience:joined", audience)
    {:noreply, socket}
  end
end