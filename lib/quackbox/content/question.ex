defmodule Quackbox.Content.Question do
  use Ecto.Schema
  import Ecto.Changeset

  schema "questions" do
    field :lie, :string
    field :prompt, :string
    field :truth, :string

    timestamps()
  end

  @doc false
  def changeset(question, attrs) do
    question
    |> cast(attrs, [:prompt, :truth, :lie])
    |> validate_required([:prompt, :truth, :lie])
  end
end
