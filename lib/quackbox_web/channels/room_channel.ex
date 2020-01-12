defmodule QuackboxWeb.RoomChannel do
  use QuackboxWeb, :channel
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
  def handle_in("start_game", _params, %{assigns: %{current_player_id: _player_id, room_id: room_id}} = socket), 
    do: Player.start_game(room_id, socket)

  def handle_info({:after_player_join, player}, socket),
    do: Player.after_player_join(player, socket)

  def handle_info({:after_audience_join, audience}, socket), 
    do: Audience.after_audience_join(audience, socket)

  def handle_info({:after_start_game, response}, socket), 
    do: Player.after_start_game(response, socket)
end
