defmodule Quackbox.Games.Room do
  use Ecto.Schema
  import Ecto.Query
  import Ecto.Changeset

  schema "rooms" do
    field :player_code, :string
    field :game_id, :id
    field :user_id, :id

    timestamps()
  end

  @doc false
  def changeset(room, attrs) do
    room
    |> cast(attrs, [:game_id, :user_id])
    |> generate_player_code()
    |> validate_required([:game_id, :user_id, :player_code])
  end

  defp generate_player_code(%Ecto.Changeset{} = changes) do
    case attempt_player_code() do
      {:halt, [code, _tries]} ->
        put_change(changes, :player_code, code)
      {:cont, tries} ->
        add_error(changes, :player_code, "After #{tries} attempts, player_code could not be generated.")
      end
  end

  @doc false
  defp attempt_player_code() do
    Enum.reduce_while(1..5, 0, fn x, acc ->
      player_code = Nanoid.generate()
      query = from r in Room, where: r.open == false and r.player_code == ^player_code

      if Repo.exists?(query) do
        {:cont, acc + x}
      else
        {:halt, [player_code, acc]}
      end
    end)
  end
end
