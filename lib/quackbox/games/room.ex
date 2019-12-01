defmodule Quackbox.Games.Room do
  use Ecto.Schema
  import Ecto.Query
  import Ecto.Changeset

  alias Quackbox.Repo
  alias Quackbox.Games.{Room}

  schema "rooms" do
    field :access_code, :string
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
