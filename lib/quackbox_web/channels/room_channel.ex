defmodule QuackboxWeb.RoomChannel do
  use QuackboxWeb, :channel

  def join("room:" <> room_id, _params, socket) do
    player_id = socket.assigns[:current_player_id]
    audience_id = socket.assigns[:current_audience_id]

    if player_id || audience_id do
      {:ok, %{channel: "room:#{room_id}"}, socket}
    else
      {:error, %{reason: "Invalid session."}}
    end
  end
end