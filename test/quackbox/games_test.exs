defmodule Quackbox.GamesTest do
  use Quackbox.DataCase

  alias Quackbox.Games

  describe "games" do
    alias Quackbox.Games.Game

    @valid_attrs %{description: "some description", name: "some name"}
    @update_attrs %{description: "some updated description", name: "some updated name"}
    @invalid_attrs %{description: nil, name: nil}

    def game_fixture(attrs \\ %{}) do
      {:ok, game} =
        attrs
        |> Enum.into(@valid_attrs)
        |> Games.create_game()

      game
    end

    test "list_games/0 returns all games" do
      game = game_fixture()
      assert Games.list_games() == [game]
    end

    test "get_game!/1 returns the game with given id" do
      game = game_fixture()
      assert Games.get_game!(game.id) == game
    end

    test "create_game/1 with valid data creates a game" do
      assert {:ok, %Game{} = game} = Games.create_game(@valid_attrs)
      assert game.description == "some description"
      assert game.name == "some name"
    end

    test "create_game/1 with invalid data returns error changeset" do
      assert {:error, %Ecto.Changeset{}} = Games.create_game(@invalid_attrs)
    end

    test "update_game/2 with valid data updates the game" do
      game = game_fixture()
      assert {:ok, %Game{} = game} = Games.update_game(game, @update_attrs)
      assert game.description == "some updated description"
      assert game.name == "some updated name"
    end

    test "update_game/2 with invalid data returns error changeset" do
      game = game_fixture()
      assert {:error, %Ecto.Changeset{}} = Games.update_game(game, @invalid_attrs)
      assert game == Games.get_game!(game.id)
    end

    test "delete_game/1 deletes the game" do
      game = game_fixture()
      assert {:ok, %Game{}} = Games.delete_game(game)
      assert_raise Ecto.NoResultsError, fn -> Games.get_game!(game.id) end
    end

    test "change_game/1 returns a game changeset" do
      game = game_fixture()
      assert %Ecto.Changeset{} = Games.change_game(game)
    end
  end

  describe "rooms" do
    alias Quackbox.Games.Room

    @valid_attrs %{finished_at: ~D[2010-04-17], max_players: 42, access_code: "some access_code"}
    @update_attrs %{finished_at: ~D[2011-05-18], max_players: 43, access_code: "some updated access_code"}
    @invalid_attrs %{finished_at: nil, max_players: nil, access_code: nil}

    def room_fixture(attrs \\ %{}) do
      {:ok, room} =
        attrs
        |> Enum.into(@valid_attrs)
        |> Games.create_room()

      room
    end

    test "list_rooms/0 returns all rooms" do
      room = room_fixture()
      assert Games.list_rooms() == [room]
    end

    test "get_room!/1 returns the room with given id" do
      room = room_fixture()
      assert Games.get_room!(room.id) == room
    end

    test "create_room/1 with valid data creates a room" do
      assert {:ok, %Room{} = room} = Games.create_room(@valid_attrs)
      assert room.finished_at == ~D[2010-04-17]
      assert room.max_players == 42
      assert room.access_code == "some access_code"
    end

    test "create_room/1 with invalid data returns error changeset" do
      assert {:error, %Ecto.Changeset{}} = Games.create_room(@invalid_attrs)
    end

    test "update_room/2 with valid data updates the room" do
      room = room_fixture()
      assert {:ok, %Room{} = room} = Games.update_room(room, @update_attrs)
      assert room.finished_at == ~D[2011-05-18]
      assert room.max_players == 43
      assert room.access_code == "some updated access_code"
    end

    test "update_room/2 with invalid data returns error changeset" do
      room = room_fixture()
      assert {:error, %Ecto.Changeset{}} = Games.update_room(room, @invalid_attrs)
      assert room == Games.get_room!(room.id)
    end

    test "delete_room/1 deletes the room" do
      room = room_fixture()
      assert {:ok, %Room{}} = Games.delete_room(room)
      assert_raise Ecto.NoResultsError, fn -> Games.get_room!(room.id) end
    end

    test "change_room/1 returns a room changeset" do
      room = room_fixture()
      assert %Ecto.Changeset{} = Games.change_room(room)
    end
  end

  describe "players" do
    alias Quackbox.Games.Player

    @valid_attrs %{name: "some name", token: "some token"}
    @update_attrs %{name: "some updated name", token: "some updated token"}
    @invalid_attrs %{name: nil, token: nil}

    def player_fixture(attrs \\ %{}) do
      {:ok, player} =
        attrs
        |> Enum.into(@valid_attrs)
        |> Games.create_player()

      player
    end

    test "list_players/0 returns all players" do
      player = player_fixture()
      assert Games.list_players() == [player]
    end

    test "get_player!/1 returns the player with given id" do
      player = player_fixture()
      assert Games.get_player!(player.id) == player
    end

    test "create_player/1 with valid data creates a player" do
      assert {:ok, %Player{} = player} = Games.create_player(@valid_attrs)
      assert player.name == "some name"
      assert player.token == "some token"
    end

    test "create_player/1 with invalid data returns error changeset" do
      assert {:error, %Ecto.Changeset{}} = Games.create_player(@invalid_attrs)
    end

    test "update_player/2 with valid data updates the player" do
      player = player_fixture()
      assert {:ok, %Player{} = player} = Games.update_player(player, @update_attrs)
      assert player.name == "some updated name"
      assert player.token == "some updated token"
    end

    test "update_player/2 with invalid data returns error changeset" do
      player = player_fixture()
      assert {:error, %Ecto.Changeset{}} = Games.update_player(player, @invalid_attrs)
      assert player == Games.get_player!(player.id)
    end

    test "delete_player/1 deletes the player" do
      player = player_fixture()
      assert {:ok, %Player{}} = Games.delete_player(player)
      assert_raise Ecto.NoResultsError, fn -> Games.get_player!(player.id) end
    end

    test "change_player/1 returns a player changeset" do
      player = player_fixture()
      assert %Ecto.Changeset{} = Games.change_player(player)
    end
  end

  describe "audience_members" do
    alias Quackbox.Games.AudienceMember

    @valid_attrs %{name: "some name", token: "some token"}
    @update_attrs %{name: "some updated name", token: "some updated token"}
    @invalid_attrs %{name: nil, token: nil}

    def audience_member_fixture(attrs \\ %{}) do
      {:ok, audience_member} =
        attrs
        |> Enum.into(@valid_attrs)
        |> Games.create_audience_member()

      audience_member
    end

    test "list_audience_members/0 returns all audience_members" do
      audience_member = audience_member_fixture()
      assert Games.list_audience_members() == [audience_member]
    end

    test "get_audience_member!/1 returns the audience_member with given id" do
      audience_member = audience_member_fixture()
      assert Games.get_audience_member!(audience_member.id) == audience_member
    end

    test "create_audience_member/1 with valid data creates a audience_member" do
      assert {:ok, %AudienceMember{} = audience_member} = Games.create_audience_member(@valid_attrs)
      assert audience_member.name == "some name"
      assert audience_member.token == "some token"
    end

    test "create_audience_member/1 with invalid data returns error changeset" do
      assert {:error, %Ecto.Changeset{}} = Games.create_audience_member(@invalid_attrs)
    end

    test "update_audience_member/2 with valid data updates the audience_member" do
      audience_member = audience_member_fixture()
      assert {:ok, %AudienceMember{} = audience_member} = Games.update_audience_member(audience_member, @update_attrs)
      assert audience_member.name == "some updated name"
      assert audience_member.token == "some updated token"
    end

    test "update_audience_member/2 with invalid data returns error changeset" do
      audience_member = audience_member_fixture()
      assert {:error, %Ecto.Changeset{}} = Games.update_audience_member(audience_member, @invalid_attrs)
      assert audience_member == Games.get_audience_member!(audience_member.id)
    end

    test "delete_audience_member/1 deletes the audience_member" do
      audience_member = audience_member_fixture()
      assert {:ok, %AudienceMember{}} = Games.delete_audience_member(audience_member)
      assert_raise Ecto.NoResultsError, fn -> Games.get_audience_member!(audience_member.id) end
    end

    test "change_audience_member/1 returns a audience_member changeset" do
      audience_member = audience_member_fixture()
      assert %Ecto.Changeset{} = Games.change_audience_member(audience_member)
    end
  end
end
