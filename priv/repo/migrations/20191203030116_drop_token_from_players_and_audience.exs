defmodule Quackbox.Repo.Migrations.DropTokenFromPlayersAndAudience do
  use Ecto.Migration

  def change do
    alter table(:players) do
      remove :token
    end

    alter table(:audience_members) do
      remove :token
    end
  end
end
