defmodule Quackbox.Games do
  @moduledoc """
  The Games context.
  """

  import Ecto.Query, warn: false
  alias Quackbox.Repo
  alias Quackbox.Games.{Game, Player, AudienceMember, Room}

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

  Raises `Ecto.NoResultsError` if the Game does not exist.

  ## Examples

      iex> get_game!(123)
      %Game{}

      iex> get_game!(456)
      ** (Ecto.NoResultsError)

  """
  def get_game!(id), do: Repo.get!(Game, id)

  @doc """
  Creates a game.

  ## Examples

      iex> create_game(%{field: value})
      {:ok, %Game{}}

      iex> create_game(%{field: bad_value})
      {:error, %Ecto.Changeset{}}

  """
  def create_game(attrs \\ %{}) do
    %Game{}
    |> Game.changeset(attrs)
    |> Repo.insert()
  end

  @doc """
  Updates a game.

  ## Examples

      iex> update_game(game, %{field: new_value})
      {:ok, %Game{}}

      iex> update_game(game, %{field: bad_value})
      {:error, %Ecto.Changeset{}}

  """
  def update_game(%Game{} = game, attrs) do
    game
    |> Game.changeset(attrs)
    |> Repo.update()
  end

  @doc """
  Deletes a Game.

  ## Examples

      iex> delete_game(game)
      {:ok, %Game{}}

      iex> delete_game(game)
      {:error, %Ecto.Changeset{}}

  """
  def delete_game(%Game{} = game) do
    Repo.delete(game)
  end

  @doc """
  Returns an `%Ecto.Changeset{}` for tracking game changes.

  ## Examples

      iex> change_game(game)
      %Ecto.Changeset{source: %Game{}}

  """
  def change_game(%Game{} = game) do
    Ecto.Changeset.change(game)
  end

  def new_game() do
    Ecto.Changeset.change(%Game{})
  end

  @doc """
  Returns the list of rooms.

  ## Examples

      iex> list_rooms()
      [%Room{}, ...]

  """
  def list_rooms do
    Repo.all(Room)
  end

  @doc """
  Gets a single room.

  Raises `Ecto.NoResultsError` if the Room does not exist.

  ## Examples

      iex> get_room!(123)
      %Room{}

      iex> get_room!(456)
      ** (Ecto.NoResultsError)

  """
  def get_room!(access_code) do
    query = from r in Room,
          where: r.access_code == ^access_code,
          where: is_nil(r.finished_at),
          preload: [:players],
          preload: [:audience_members]
          
    Repo.all(query)
  end

  # Allows us to display the name of the player who is
  # choosing a category
  def get_room_chooser!(chooser_id) do
    Repo.get(Player, chooser_id)
  end

  # Retrieve a random player from the room. This is used
  # to assign a player as the "chooser" for a round
  def get_random_room_player!(room_id) do
    query = from p in Player,
      where: p.room_id == ^room_id,
      order_by: fragment("RANDOM()")

    Repo.one(query)
  end

  @doc """
  Creates a room.

  ## Examples

      iex> create_room(%{field: value})
      {:ok, %Room{}}

      iex> create_room(%{field: bad_value})
      {:error, %Ecto.Changeset{}}

  """
  def create_room(attrs \\ %{}) do
    %Room{}
    |> Room.new_changeset(attrs)
    |> Repo.insert()
  end

  @doc """
  Updates a room.

  ## Examples

      iex> update_room(room, %{field: new_value})
      {:ok, %Room{}}

      iex> update_room(room, %{field: bad_value})
      {:error, %Ecto.Changeset{}}

  """
  def update_room(%Room{} = room, attrs) do
    room
    |> Room.changeset(attrs)
    |> Repo.update()
  end

  @doc """
  Deletes a Room.

  ## Examples

      iex> delete_room(room)
      {:ok, %Room{}}

      iex> delete_room(room)
      {:error, %Ecto.Changeset{}}

  """
  def delete_room(%Room{} = room) do
    Repo.delete(room)
  end

  @doc """
  Returns an `%Ecto.Changeset{}` for tracking room changes.

  ## Examples

      iex> change_room(room)
      %Ecto.Changeset{source: %Room{}}

  """
  def change_room(%Room{} = room) do
    Ecto.Changeset.change(room)
  end

  def new_room() do
    Ecto.Changeset.change(%Room{})
  end

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
  def get_player!(id) do
    query = from p in Player,
          where: p.id == ^id,
          limit: 1,
          preload: [:room]

    Repo.all(query)
  end

  @doc """
  Creates a player.

  ## Examples

      iex> create_player(%{field: value})
      {:ok, %Player{}}

      iex> create_player(%{field: bad_value})
      {:error, %Ecto.Changeset{}}

  """
  def create_player(attrs \\ %{}, room) do
    %Player{}
    |> Player.changeset(attrs, room)
    |> Repo.insert()
  end

  def create_player_or_audience_member(attrs \\ %{}) do
    case get_room!(attrs.access_code) do
      [room] ->
        if length(room.players) < room.max_players do
          create_player(attrs, room)
        else
          create_audience_member(attrs, room)
        end
      [] ->
        %Player{}
        |> Player.changeset(%{name: attrs.name}, nil)
        |> Repo.insert()
      _ ->
        nil
    end
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
    |> Player.changeset(attrs, nil)
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
    Ecto.Changeset.change(player)
  end

  def new_player() do
    Ecto.Changeset.change(%Player{})
  end

  alias Quackbox.Games.AudienceMember

  @doc """
  Returns the list of audience_members.

  ## Examples

      iex> list_audience_members()
      [%AudienceMember{}, ...]

  """
  def list_audience_members do
    Repo.all(AudienceMember)
  end

  @doc """
  Gets a single audience_member.

  Raises `Ecto.NoResultsError` if the Audience member does not exist.

  ## Examples

      iex> get_audience_member!(123)
      %AudienceMember{}

      iex> get_audience_member!(456)
      ** (Ecto.NoResultsError)

  """
  def get_audience_member!(audience_member_token) do
    query = from a in AudienceMember,
          where: a.token == ^audience_member_token,
          preload: [:room]
    
    Repo.one(query)
  end

  @doc """
  Creates a audience_member.

  ## Examples

      iex> create_audience_member(%{field: value})
      {:ok, %AudienceMember{}}

      iex> create_audience_member(%{field: bad_value})
      {:error, %Ecto.Changeset{}}

  """
  def create_audience_member(attrs \\ %{}, room) do
    %AudienceMember{}
    |> AudienceMember.changeset(attrs, room)
    |> Repo.insert()
  end

  @doc """
  Updates a audience_member.

  ## Examples

      iex> update_audience_member(audience_member, %{field: new_value})
      {:ok, %AudienceMember{}}

      iex> update_audience_member(audience_member, %{field: bad_value})
      {:error, %Ecto.Changeset{}}

  """
  def update_audience_member(%AudienceMember{} = audience_member, attrs) do
    audience_member
    |> AudienceMember.changeset(attrs, nil)
    |> Repo.update()
  end

  @doc """
  Deletes a AudienceMember.

  ## Examples

      iex> delete_audience_member(audience_member)
      {:ok, %AudienceMember{}}

      iex> delete_audience_member(audience_member)
      {:error, %Ecto.Changeset{}}

  """
  def delete_audience_member(%AudienceMember{} = audience_member) do
    Repo.delete(audience_member)
  end

  @doc """
  Returns an `%Ecto.Changeset{}` for tracking audience_member changes.

  ## Examples

      iex> change_audience_member(audience_member)
      %Ecto.Changeset{source: %AudienceMember{}}

  """
  def change_audience_member(%AudienceMember{} = audience_member) do
    AudienceMember.changeset(audience_member, %{}, nil)
  end
end
