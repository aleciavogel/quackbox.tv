defmodule Quackbox.Games.Player do
  use Ecto.Schema
  import Ecto.Changeset

  schema "players" do
    field :name, :string
    field :token, :string
    belongs_to :room, Quackbox.Games.Room

    timestamps()
  end

  @doc false
  def changeset(player, attrs) do
    player
    |> cast(attrs, [:name, :room_id])
    |> generate_token()
    |> validate_required([:name, :token, :room_id])
    |> unique_constraint(:token)
  end

  defp generate_token(changes \\ %{}) do
    chars = "0123456789abcdefghijklmnopqrstuvwxyzABCDEFGHIJKLMNOPQRSTUVWXYZ"
    token = Nanoid.generate_non_secure(21, chars)
    put_change(changes, :token, token)
  end
end
