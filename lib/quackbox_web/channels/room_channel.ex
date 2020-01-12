defmodule QuackboxWeb.RoomChannel do
  use QuackboxWeb, :channel
  alias Quackbox.Repo
  alias Quackbox.Games
  alias Quackbox.Games.{Player, AudienceMember, Room}
  alias QuackboxWeb.Presence
  alias QuackboxWeb.RoomChannel.{Host, Audience, Player}

  # Player joins the game
  def join("room:" <> access_code, _params, %{assigns: %{current_player_id: player_id}} = socket), 
    do: Player.join(access_code, player_id, socket)
  
  # Audience joins the game
  def join("room:" <> access_code, _params, %{assigns: %{current_audience_id: audience_id}} = socket),
    do: Audience.join(access_code, audience_id, socket)
  
  # Host joins the game
  def join("room:" <> access_code, _params, %{assigns: %{current_host_id: _host_id}} = socket), 
    do: Host.join(access_code, socket)
  
  # Refuse all other attempts to join
  def join(_room, _params, _socket), 
    do: {:error, %{reason: "Invalid session."}}

  # Lead player starts the game
  def handle_in("start_game", _params, %{assigns: %{current_player_id: _player_id, room_id: room_id}} = socket) do
    Room
    |> Repo.get(room_id)
    |> Room.changeset(%{current_scene: "select-category"})
    |> Repo.update

    response = %{
      scene: "select-category"
    }

    send(self(), {:after_start_game, response})
    {:noreply, socket}
  end

  def handle_info({:after_player_join, player}, socket) do
    push(socket, "presence_state", Presence.list(socket))
    {:ok, _} = Presence.track(socket, "player:#{player.id}", %{
      name: player.name,
      id: player.id,
      online_at: inspect(System.system_time(:second)),
      type: "player"
    })
    {:noreply, socket}
  end

  def handle_info({:after_audience_join, audience}, socket) do
    push(socket, "presence_state", Presence.list(socket))
    {:ok, _} = Presence.track(socket, "audience:#{audience.id}", %{
      name: audience.name,
      id: audience.id,
      type: "audience"
    })
    {:noreply, socket}
  end

  def handle_info({:after_start_game, response}, socket) do
    broadcast!(socket, "category_select", response)
    {:noreply, socket}
  end
end
