defmodule Quackbox.Games.Room do
  use Ecto.Schema
  import Ecto.Changeset

  schema "rooms" do
    field :finished_at, :date
    field :max_players, :integer
    field :access_code, :string
    field :game_id, :id
    field :user_id, :id

    timestamps()
  end

  @doc false
  def changeset(room, attrs) do
    room
    |> cast(attrs, [:access_code, :max_players, :finished_at])
    |> validate_required([:access_code, :max_players, :finished_at])
  end
end
