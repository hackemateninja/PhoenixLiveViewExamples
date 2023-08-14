defmodule LiveViewStudio.Boats.Boat do
  use Ecto.Schema
  import Ecto.Changeset

  schema "boats" do
    field :model, :string
    field :type, :string
    field :price, :string
    field :image, :string

    timestamps()
  end

  @doc false
  def changeset(boat, attrs) do
    boat
    |> cast(attrs, [:model, :type, :price, :image])
    |> validate_required([:model, :type, :price, :image])
  end
end
