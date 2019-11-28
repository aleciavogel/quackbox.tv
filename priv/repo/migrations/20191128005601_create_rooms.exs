defmodule Quackbox.Repo.Migrations.CreateRooms do
  use Ecto.Migration

  def change do
    create table(:rooms) do
      add :player_code, :string
      add :game_id, references(:games, on_delete: :nothing)
      add :user_id, references(:users, on_delete: :nothing)

      timestamps()
    end

    create unique_index(:rooms, [:player_code])
    create index(:rooms, [:game_id])
    create index(:rooms, [:user_id])
  end
end
