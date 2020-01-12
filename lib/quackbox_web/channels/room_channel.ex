defmodule QuackboxWeb.RoomChannel do
  use QuackboxWeb, :channel
  alias Quackbox.Repo
  alias Quackbox.Games.{Player, AudienceMember}
  alias QuackboxWeb.Presence

  # Player joins the game
  def join("room:" <> access_code, _params, %{assigns: %{current_player_id: player_id}} = socket) do
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
        player: player_info
      }
      send(self(), {:after_player_join, player_info})
      {:ok, response, assign(socket, :room_id, player.room.id)}
    else
      {:error, %{reason: "Invalid session."}}
    end
  end
  
  # Audience joins the game
  def join("room:" <> access_code, _params, %{assigns: %{current_audience_id: audience_id}} = socket) do
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
  
  # Host joins the game
  def join("room:" <> access_code, _params, %{assigns: %{current_host_id: _host_id}} = socket) do
    {:ok, %{channel: "room:#{access_code}", presences: Presence.list(socket)}, socket}
  end
  
  # Refuse all other attempts to join
  def join(_room, _params, _socket) do
    {:error, %{reason: "Invalid session."}}
  end

  # Lead player starts the game
  def handle_in("start_game", _params, %{assigns: %{current_player_id: _player_id}} = socket) do
    response = %{
      scene: "select-category",
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
