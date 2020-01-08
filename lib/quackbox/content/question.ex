defmodule Quackbox.Content.Question do
  use Ecto.Schema
  import Ecto.Changeset

  alias Quackbox.Content
  alias Quackbox.Content.Category

  schema "questions" do
    field :lie, :string
    field :prompt, :string
    field :truth, :string
    
    field :category_name, :string, virtual: true
    
    belongs_to :category, Category

    timestamps()
  end

  @doc false
  def changeset(question, attrs) do
    question
    |> cast(attrs, [:prompt, :truth, :lie])
    |> fetch_category(attrs)
    |> validate_required([:category_id, :prompt, :truth, :lie])
  end

  defp fetch_category(changeset, %{"category_name" => name}) do
    category = Content.get_or_insert_category!(name)
    put_change(changeset, :category_id, category.id)
  end
  defp fetch_category(changeset, _attrs) do
    changeset
  end
end
