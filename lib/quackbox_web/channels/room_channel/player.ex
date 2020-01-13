defmodule QuackboxWeb.RoomChannel.Player do
  import Phoenix.Channel, only: [push: 3, broadcast!: 3]
  import Phoenix.Socket, only: [assign: 3]

  alias Quackbox.Repo
  alias Quackbox.Games.{Player, Room}
  alias Quackbox.Content
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
        scene: player.room.current_scene,
        is_choosing: player.id == player.room.chooser_id,
        categories: player.room.category_choices || []
      }
      send(self(), {:after_player_join, player_info})
      {:ok, response, assign(socket, :room_id, player.room.id)}
    else
      {:error, %{reason: "Invalid session."}}
    end
  end

  # After a player joins the game, track their Presence
  def after_player_join(player, socket) do
    push(socket, "presence_state", Presence.list(socket))
    {:ok, _} = Presence.track(socket, "player:#{player.id}", %{
      name: player.name,
      id: player.id,
      is_lead: player.is_lead,
      online_at: inspect(System.system_time(:second)),
      type: "player"
    })
    {:noreply, socket}
  end

  # Player starts the game
  def start_game(_params, %{assigns: %{current_player_id: _player_id}} = socket) do
    chooser = set_chooser(socket)
    categories = set_choices(socket)

    response = %{
      scene: "select-category",
      chooser: chooser,
      categories: categories
    }

    send(self(), {:after_start_game, response})
    {:noreply, socket}
  end

  # After player starts the game
  def after_start_game(response, socket) do
    broadcast!(socket, "category_select", response)
    {:noreply, socket}
  end

  # Select a random player to be the designated "chooser" 
  defp set_chooser(%{assigns: %{room_id: room_id}} = socket) do
    chooser = 
      Presence.list(socket)
      |> pick_random_online_player

    Room
    |> Repo.get(room_id)
    |> Room.changeset(%{current_scene: "select-category", chooser_id: chooser.id})
    |> Repo.update

    chooser
  end

  defp set_choices(%{assigns: %{room_id: room_id}}) do
    categories = Content.pick_random_categories

    Room
    |> Repo.get(room_id)
    |> Room.changeset(%{category_choices: categories})
    |> Repo.update

    categories
  end

  # Returns a random presence
  defp pick_random_online_player(presences) do
    {_, %{metas: [player]}} = Enum.random(presences)
    random_player?(presences, player)
  end

  # Validate that the randomly selected presence is a player
  defp random_player?(_presences, %{type: "player"} = player), do: player
  defp random_player?(presences, %{type: "audience"}) do
    pick_random_online_player(presences)
  end
end
