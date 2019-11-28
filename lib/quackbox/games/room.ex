defmodule Quackbox.Games.Room do
  use Ecto.Schema
  import Ecto.Query
  import Ecto.Changeset

  alias Quackbox.Repo
  alias Quackbox.Games.{Room}

  schema "rooms" do
    field :player_code, :string
    field :max_players, :integer
    field :finished_at, :date

    field :game_id, :id
    field :user_id, :id

    timestamps()
  end

  @doc false
  def changeset(room, attrs) do
    room
    |> cast(attrs, [:game_id, :user_id, :max_players])
    |> validate_required([:game_id, :user_id, :max_players])
    |> generate_player_code()
  end

  @doc false
  defp generate_player_code(%Ecto.Changeset{} = changes) do
    case attempt_player_code() do
      {:halt, [_code, tries]} ->
        add_error(changes, :player_code, "After #{tries} attempts, player_code could not be generated.")
      {:cont, tries} ->
        add_error(changes, :player_code, "After #{tries} attempts, player_code could not be generated.")
      [code, _tries] ->
        put_change(changes, :player_code, code)
      end
  end

  @doc false
  defp attempt_player_code() do
    Enum.reduce_while(1..5, 0, fn x, acc ->
      player_code = Nanoid.generate()
      
      query = from r in Room, 
            where: is_nil(r.finished_at),
            where: r.player_code == ^player_code

      if Repo.exists?(query) do
        {:cont, acc + x}
      else
        {:halt, [player_code, acc]}
      end
    end)
  end
end
