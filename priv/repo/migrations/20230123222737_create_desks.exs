defmodule LiveViewStudio.Repo.Migrations.CreateDesks do
  use Ecto.Migration

  def change do
    create table(:desks) do
      add :name, :string
      add :photo_locations, {:array, :string}, null: false, default: []

      timestamps()
    end
  end
end
