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
    |> generate_token()
    |> validate_required([:name, :token])
    |> unique_constraint(:token)
    |> put_assoc?(:room, room)
  end

  defp generate_token(changes) do
    chars = "0123456789abcdefghijklmnopqrstuvwxyzABCDEFGHIJKLMNOPQRSTUVWXYZ"
    token = Nanoid.generate_non_secure(21, chars)
    put_change(changes, :token, token)
  end

  defp put_assoc?(changes, _atom, nil) do
    add_error(changes, :access_code, "does not exist.")
  end
  defp put_assoc?(changes, atom, records) do
    put_assoc(changes, atom, records)
  end
end
