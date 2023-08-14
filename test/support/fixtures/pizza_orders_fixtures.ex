defmodule LiveViewStudio.PizzaOrdersFixtures do
  @moduledoc """
  This module defines test helpers for creating
  entities via the `LiveViewStudio.PizzaOrders` context.
  """

  @doc """
  Generate a pizza_order.
  """
  def pizza_order_fixture(attrs \\ %{}) do
    {:ok, pizza_order} =
      attrs
      |> Enum.into(%{
        price: "120.5",
        size: "some size",
        style: "some style",
        topping_1: "some topping_1",
        topping_2: "some topping_2"
      })
      |> LiveViewStudio.PizzaOrders.create_pizza_order()

    pizza_order
  end
end
