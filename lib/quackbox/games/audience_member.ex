defmodule Quackbox.Games.AudienceMember do
  use Ecto.Schema
  import Ecto.Changeset

  schema "audience_members" do
    field :name, :string
    field :token, :string
    field :room_id, :id

    timestamps()
  end

  @doc false
  def changeset(audience_member, attrs) do
    audience_member
    |> cast(attrs, [:name, :token])
    |> validate_required([:name, :token])
    |> unique_constraint(:token)
  end
end
