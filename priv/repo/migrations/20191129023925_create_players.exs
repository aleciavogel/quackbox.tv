defmodule Quackbox.Repo.Migrations.CreatePlayers do
  use Ecto.Migration

  def change do
    create table(:players) do
      add :name, :string
      add :token, :string
      add :room_id, references(:rooms, on_delete: :nothing)

      timestamps()
    end

    create unique_index(:players, [:token])
    create index(:players, [:room_id])
  end
end
