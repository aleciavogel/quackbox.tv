defmodule Quackbox.Games.Room do
  use Ecto.Schema
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
    |> cast(attrs, [:player_code])
    |> validate_required([:player_code])
    |> unique_constraint(:player_code)
  end
end
