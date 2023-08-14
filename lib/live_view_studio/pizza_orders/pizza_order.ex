defmodule LiveViewStudio.PizzaOrders.PizzaOrder do
  use Ecto.Schema
  import Ecto.Changeset

  schema "pizza_orders" do
    field :size, :string
    field :style, :string
    field :topping_1, :string
    field :topping_2, :string
    field :price, :decimal

    timestamps()
  end

  @doc false
  def changeset(pizza_order, attrs) do
    pizza_order
    |> cast(attrs, [:size, :style, :topping_1, :topping_2, :price])
    |> validate_required([:size, :style, :topping_1, :topping_2, :price])
  end
end
