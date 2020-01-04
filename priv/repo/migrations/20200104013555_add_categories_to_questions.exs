defmodule Quackbox.Repo.Migrations.AddCategoriesToQuestions do
  use Ecto.Migration

  def change do
    alter table(:questions) do
      add :category_id, references(:categories, on_delete: :nothing)
    end
    
    create index(:questions, [:category_id])
  end
end
