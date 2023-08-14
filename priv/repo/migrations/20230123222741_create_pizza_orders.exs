defmodule LiveViewStudio.Repo.Migrations.CreatePizzaOrders do
  use Ecto.Migration

  def change do
    create table(:pizza_orders) do
      add :size, :string
      add :style, :string
      add :topping_1, :string
      add :topping_2, :string
      add :price, :decimal

      timestamps()
    end
  end
end
