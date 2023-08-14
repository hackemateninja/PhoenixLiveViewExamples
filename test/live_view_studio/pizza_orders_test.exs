defmodule LiveViewStudio.PizzaOrdersTest do
  use LiveViewStudio.DataCase

  alias LiveViewStudio.PizzaOrders

  describe "pizza_orders" do
    alias LiveViewStudio.PizzaOrders.PizzaOrder

    import LiveViewStudio.PizzaOrdersFixtures

    @invalid_attrs %{price: nil, size: nil, style: nil, topping_1: nil, topping_2: nil}

    test "list_pizza_orders/0 returns all pizza_orders" do
      pizza_order = pizza_order_fixture()
      assert PizzaOrders.list_pizza_orders() == [pizza_order]
    end

    test "list_pizza_orders/1 returns pizza_orders in sorted order" do
      c = pizza_order_fixture(style: "c", price: 2)
      a = pizza_order_fixture(style: "a", price: 3)
      b = pizza_order_fixture(style: "b", price: 1)

      options = %{sort_by: :style, sort_order: :asc}

      assert PizzaOrders.list_pizza_orders(options) == [a, b, c]

      options = %{sort_by: :price, sort_order: :desc}

      assert PizzaOrders.list_pizza_orders(options) == [a, c, b]
    end

    test "list_pizza_orders/1 returns pizza_orders in pages" do
      a = pizza_order_fixture(style: "a")
      b = pizza_order_fixture(style: "b")
      c = pizza_order_fixture(style: "c")
      d = pizza_order_fixture(style: "d")
      e = pizza_order_fixture(style: "e")

      options = %{page: 1, per_page: 10}

      assert PizzaOrders.list_pizza_orders(options) == [a, b, c, d, e]

      options = %{page: 2, per_page: 2}

      assert PizzaOrders.list_pizza_orders(options) == [c, d]

      options = %{page: 3, per_page: 1}

      assert PizzaOrders.list_pizza_orders(options) == [c]
    end

    test "get_pizza_order!/1 returns the pizza_order with given id" do
      pizza_order = pizza_order_fixture()
      assert PizzaOrders.get_pizza_order!(pizza_order.id) == pizza_order
    end

    test "create_pizza_order/1 with valid data creates a pizza_order" do
      valid_attrs = %{
        price: "120.5",
        size: "some size",
        style: "some style",
        topping_1: "some topping_1",
        topping_2: "some topping_2"
      }

      assert {:ok, %PizzaOrder{} = pizza_order} = PizzaOrders.create_pizza_order(valid_attrs)
      assert pizza_order.price == Decimal.new("120.5")
      assert pizza_order.size == "some size"
      assert pizza_order.style == "some style"
      assert pizza_order.topping_1 == "some topping_1"
      assert pizza_order.topping_2 == "some topping_2"
    end

    test "create_pizza_order/1 with invalid data returns error changeset" do
      assert {:error, %Ecto.Changeset{}} = PizzaOrders.create_pizza_order(@invalid_attrs)
    end

    test "update_pizza_order/2 with valid data updates the pizza_order" do
      pizza_order = pizza_order_fixture()

      update_attrs = %{
        price: "456.7",
        size: "some updated size",
        style: "some updated style",
        topping_1: "some updated topping_1",
        topping_2: "some updated topping_2"
      }

      assert {:ok, %PizzaOrder{} = pizza_order} =
               PizzaOrders.update_pizza_order(pizza_order, update_attrs)

      assert pizza_order.price == Decimal.new("456.7")
      assert pizza_order.size == "some updated size"
      assert pizza_order.style == "some updated style"
      assert pizza_order.topping_1 == "some updated topping_1"
      assert pizza_order.topping_2 == "some updated topping_2"
    end

    test "update_pizza_order/2 with invalid data returns error changeset" do
      pizza_order = pizza_order_fixture()

      assert {:error, %Ecto.Changeset{}} =
               PizzaOrders.update_pizza_order(pizza_order, @invalid_attrs)

      assert pizza_order == PizzaOrders.get_pizza_order!(pizza_order.id)
    end

    test "delete_pizza_order/1 deletes the pizza_order" do
      pizza_order = pizza_order_fixture()
      assert {:ok, %PizzaOrder{}} = PizzaOrders.delete_pizza_order(pizza_order)
      assert_raise Ecto.NoResultsError, fn -> PizzaOrders.get_pizza_order!(pizza_order.id) end
    end

    test "change_pizza_order/1 returns a pizza_order changeset" do
      pizza_order = pizza_order_fixture()
      assert %Ecto.Changeset{} = PizzaOrders.change_pizza_order(pizza_order)
    end
  end
end
