defmodule QuackboxWeb.RoomChannel do
  use QuackboxWeb, :channel

  def join(channel_name, _params, socket) do
    {:ok, %{channel: channel_name}, socket}
  end
end