defmodule Quackbox.Games do
  @moduledoc """
  The Games context.
  """
  import Ecto.Query, warn: false
  alias Quackbox.Repo

  alias Quackbox.Games.{Game, Room}

  @doc """
  Returns the list of games.

  ## Examples

      iex> list_games()
      [%Game{}, ...]

  """
  def list_games do
    query = from g in Game,
          select: {g.name, g.id}

    Repo.all(query)
  end

  @doc """
  Gets a single game.

  Raises if the Game does not exist.

  ## Examples

      iex> get_game!(123)
      %Game{}

  """
  def get_game!(id), do: raise "TODO"

  @doc """
  Creates a game.

  ## Examples

      iex> create_game(%{field: value})
      {:ok, %Game{}}

      iex> create_game(%{field: bad_value})
      {:error, ...}

  """
  def create_game(attrs \\ %{}) do
    raise "TODO"
  end

  @doc """
  Updates a game.

  ## Examples

      iex> update_game(game, %{field: new_value})
      {:ok, %Game{}}

      iex> update_game(game, %{field: bad_value})
      {:error, ...}

  """
  def update_game(%Game{} = game, attrs) do
    raise "TODO"
  end

  @doc """
  Deletes a Game.

  ## Examples

      iex> delete_game(game)
      {:ok, %Game{}}

      iex> delete_game(game)
      {:error, ...}

  """
  def delete_game(%Game{} = game) do
    raise "TODO"
  end

  @doc """
  Returns a data structure for tracking game changes.

  ## Examples

      iex> change_game(game)
      %Todo{...}

  """
  def change_game(%Game{} = game) do
    raise "TODO"
  end

  alias Quackbox.Games.Room

  @doc """
  Returns the list of rooms.

  ## Examples

      iex> list_rooms()
      [%Room{}, ...]

  """
  def list_rooms do
    raise "TODO"
  end

  @doc """
  Gets a single room.

  Raises if the Room does not exist.

  ## Examples

      iex> get_room!(123)
      %Room{}

  """
  def get_room!(player_code) do
    query = from r in Room,
          where: r.player_code == ^player_code
          
    Repo.one(query)
  end

  @doc """
  Creates a room.

  ## Examples

      iex> create_room(%{field: value})
      {:ok, %Room{}}

      iex> create_room(%{field: bad_value})
      {:error, ...}

  """
  def create_room(attrs \\ %{}) do
    %Room{}
    |> Room.changeset(attrs)
    |> Repo.insert!()
  end

  @doc """
  Updates a room.

  ## Examples

      iex> update_room(room, %{field: new_value})
      {:ok, %Room{}}

      iex> update_room(room, %{field: bad_value})
      {:error, ...}

  """
  def update_room(%Room{} = room, attrs) do
    raise "TODO"
  end

  @doc """
  Deletes a Room.

  ## Examples

      iex> delete_room(room)
      {:ok, %Room{}}

      iex> delete_room(room)
      {:error, ...}

  """
  def delete_room(%Room{} = room) do
    raise "TODO"
  end

  @doc """
  Returns a data structure for tracking room changes.

  ## Examples

      iex> change_room(room)
      %Todo{...}

  """
  def change_room(%Room{} = room) do
    raise "TODO"
  end

  alias Quackbox.Games.Player

  @doc """
  Returns the list of players.

  ## Examples

      iex> list_players()
      [%Player{}, ...]

  """
  def list_players do
    Repo.all(Player)
  end

  @doc """
  Gets a single player.

  Raises `Ecto.NoResultsError` if the Player does not exist.

  ## Examples

      iex> get_player!(123)
      %Player{}

      iex> get_player!(456)
      ** (Ecto.NoResultsError)

  """
  def get_player!(id), do: Repo.get!(Player, id)

  @doc """
  Creates a player.

  ## Examples

      iex> create_player(%{field: value})
      {:ok, %Player{}}

      iex> create_player(%{field: bad_value})
      {:error, %Ecto.Changeset{}}

  """
  def create_player(attrs \\ %{}) do
    %Player{}
    |> Player.changeset(attrs)
    |> Repo.insert()
  end

  @doc """
  Updates a player.

  ## Examples

      iex> update_player(player, %{field: new_value})
      {:ok, %Player{}}

      iex> update_player(player, %{field: bad_value})
      {:error, %Ecto.Changeset{}}

  """
  def update_player(%Player{} = player, attrs) do
    player
    |> Player.changeset(attrs)
    |> Repo.update()
  end

  @doc """
  Deletes a Player.

  ## Examples

      iex> delete_player(player)
      {:ok, %Player{}}

      iex> delete_player(player)
      {:error, %Ecto.Changeset{}}

  """
  def delete_player(%Player{} = player) do
    Repo.delete(player)
  end

  @doc """
  Returns an `%Ecto.Changeset{}` for tracking player changes.

  ## Examples

      iex> change_player(player)
      %Ecto.Changeset{source: %Player{}}

  """
  def change_player(%Player{} = player) do
    Player.changeset(player, %{})
  end
end
