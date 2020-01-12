defmodule Quackbox.Games.Room do
  use Ecto.Schema
  import Ecto.Query
  import Ecto.Changeset

  alias Quackbox.Repo
  alias Quackbox.Games.{Game, Player, AudienceMember, Room}
  alias Quackbox.Users.User

  schema "rooms" do
    field :access_code, :string
    field :max_players, :integer
    field :finished_at, :date
    field :current_scene, :string, default: "game-start"
    field :chooser_id, :integer
    field :category_choices, {:array, :string}, default: []

    belongs_to :game, Game
    belongs_to :user, User
    has_many :players, Player
    has_many :audience_members, AudienceMember

    timestamps()
  end

  @doc false
  @required_fields [:game_id, :user_id, :max_players]
  @valid_fields [:game_id, :user_id, :max_players, :current_scene, :chooser_id, :category_choices]
  @valid_scenes ~w(game-start select-category answering voting leaderboard game-end)
  def changeset(room, attrs) do
    room
    |> cast(attrs, @valid_fields)
    |> validate_required(@required_fields)
    |> validate_inclusion(:current_scene, @valid_scenes)
  end

  def new_changeset(room, attrs) do
    room
    |> changeset(attrs)
    |> generate_access_code()
  end

  @doc false
  defp generate_access_code(%Ecto.Changeset{} = changes) do
    case attempt_access_code() do
      {:halt, [_code, tries]} ->
        add_error(changes, :access_code, "After #{tries} attempts, access_code could not be generated.")
      {:cont, tries} ->
        add_error(changes, :access_code, "After #{tries} attempts, access_code could not be generated.")
      [code, _tries] ->
        put_change(changes, :access_code, code)
      end
  end

  @doc false
  defp attempt_access_code() do
    Enum.reduce_while(1..5, 0, fn x, acc ->
      access_code = Nanoid.generate()
      
      query = from r in Room, 
            where: is_nil(r.finished_at),
            where: r.access_code == ^access_code

      if Repo.exists?(query) do
        {:cont, acc + x}
      else
        {:halt, [access_code, acc]}
      end
    end)
  end
end
