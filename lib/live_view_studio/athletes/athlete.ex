defmodule LiveViewStudio.Athletes.Athlete do
  use Ecto.Schema
  import Ecto.Changeset

  schema "athletes" do
    field :name, :string
    field :emoji, :string
    field :sport, :string
    field :status, Ecto.Enum, values: [:training, :competing, :resting]

    timestamps()
  end

  @doc false
  def changeset(athlete, attrs) do
    athlete
    |> cast(attrs, [:name, :emoji, :sport, :status])
    |> validate_required([:name, :emoji, :sport, :status])
  end
end
