defmodule Quackbox.Repo.Migrations.CreateAudienceMembers do
  use Ecto.Migration

  def change do
    create table(:audience_members) do
      add :name, :string
      add :token, :string
      add :room_id, references(:rooms, on_delete: :nothing)

      timestamps()
    end

    create unique_index(:audience_members, [:token])
    create index(:audience_members, [:room_id])
  end
end
