defmodule LiveViewStudio.Desks.Desk do
  use Ecto.Schema
  import Ecto.Changeset

  schema "desks" do
    field :name, :string
    field :photo_locations, {:array, :string}, default: []

    timestamps()
  end

  @doc false
  def changeset(desk, attrs) do
    desk
    |> cast(attrs, [:name, :photo_locations])
    |> validate_required([:name, :photo_locations])
  end
end
