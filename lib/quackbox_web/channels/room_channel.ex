defmodule QuackboxWeb.RoomChannel do
  use QuackboxWeb, :channel
  import QuackboxWeb.RoomChannel.MessagesHandler
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

  handle_incoming [
    :start_game
  ], with_module: Player

  handle_broadcasts [
    :after_player_join,
    :after_start_game
  ], with_module: Player

  handle_broadcasts [
    :after_audience_join
  ], with_module: Audience
end
