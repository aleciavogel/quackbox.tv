defmodule Quackbox.Games.Player do
  use Ecto.Schema
  import Ecto.Changeset

  schema "players" do
    field :name, :string
    belongs_to :room, Quackbox.Games.Room

    timestamps()
  end

  @doc false
  def changeset(player, attrs, room) do
    player
    |> cast(attrs, [:name])
    |> validate_required([:name])
    |> put_assoc?(:room, room)
  end

  defp put_assoc?(changes, _atom, nil) do
    add_error(changes, :access_code, "does not exist.")
  end
  defp put_assoc?(changes, atom, records) do
    put_assoc(changes, atom, records)
  end
end
