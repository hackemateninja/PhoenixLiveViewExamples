defmodule LiveViewStudio.Servers.Server do
  use Ecto.Schema
  import Ecto.Changeset

  schema "servers" do
    field :name, :string
    field :status, :string, default: "down"
    field :deploy_count, :integer, default: 0
    field :size, :float
    field :framework, :string
    field :last_commit_message, :string

    timestamps()
  end

  @doc false
  def changeset(server, attrs) do
    server
    |> cast(attrs, [:name, :status, :deploy_count, :size, :framework, :last_commit_message])
    |> validate_required([:name, :framework, :size])
    |> validate_length(:name, min: 2, max: 100)
    |> validate_length(:framework, min: 2, max: 50)
    |> validate_number(:size, greater_than: 0)
    |> validate_inclusion(:status, ["up", "down"])
  end
end
