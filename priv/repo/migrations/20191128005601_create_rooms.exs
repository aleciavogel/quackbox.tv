defmodule Quackbox.Repo.Migrations.CreateRooms do
  use Ecto.Migration

  def change do
    create table(:rooms) do
      add :access_code, :string
      add :max_players, :integer
      add :finished_at, :date

      add :game_id, references(:games, on_delete: :nothing)
      add :user_id, references(:users, on_delete: :nothing)

      timestamps()
    end

    create index(:rooms, [:access_code])
    create index(:rooms, [:game_id])
    create index(:rooms, [:user_id])
  end
end
