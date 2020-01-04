defmodule Quackbox.Repo.Migrations.CreateQuestions do
  use Ecto.Migration

  def change do
    create table(:questions) do
      add :prompt, :string
      add :truth, :string
      add :lie, :string

      timestamps()
    end

  end
end
