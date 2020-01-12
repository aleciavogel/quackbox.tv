defmodule Quackbox.Repo.Migrations.AddCategoryFieldsToRooms do
  use Ecto.Migration

  def change do
    alter table(:rooms) do
      add :current_scene, :string, default: "game-start"
      add :category_choices, {:array, :string}, default: []
      add :chooser_id, :integer
    end
  end
end
