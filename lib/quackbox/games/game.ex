defmodule Quackbox.Games.Game do
  use Ecto.Schema
  import Ecto.Changeset
  alias Quackbox.Games.Room

  schema "games" do
    field :description, :string
    field :name, :string

    has_many :rooms, Room

    timestamps()
  end

  @doc false
  def changeset(game, attrs) do
    game
    |> cast(attrs, [:name, :description])
    |> validate_required([:name, :description])
  end
end
