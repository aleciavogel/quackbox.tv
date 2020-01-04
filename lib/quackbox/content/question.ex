defmodule Quackbox.Content.Question do
  use Ecto.Schema
  import Ecto.Changeset

  alias Quackbox.Content.Category

  schema "questions" do
    field :lie, :string
    field :prompt, :string
    field :truth, :string
    
    belongs_to :category, Category

    timestamps()
  end

  @doc false
  def changeset(question, attrs) do
    question
    |> cast(attrs, [:category_id, :prompt, :truth, :lie])
    |> validate_required([:category_id, :prompt, :truth, :lie])
  end
end
