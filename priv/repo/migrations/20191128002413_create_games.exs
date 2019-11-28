defmodule Quackbox.Repo.Migrations.CreateGames do
  use Ecto.Migration

  def change do
    create table(:games) do
      add :name, :string
      add :description, :string

      timestamps()
    end

  end
end
