defmodule Quackbox.Content.Category do
  use Ecto.Schema
  import Ecto.Changeset

  alias Quackbox.Content.Question

  schema "categories" do
    field :name, :string
    
    field :question_count, :integer, virtual: true

    has_many :questions, Question

    timestamps()
  end

  @doc false
  def changeset(category, attrs) do
    category
    |> cast(attrs, [:name])
    |> validate_required([:name])
    |> unique_constraint(:name)
  end
end
