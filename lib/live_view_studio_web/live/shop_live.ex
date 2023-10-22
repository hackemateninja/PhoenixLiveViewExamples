defmodule LiveViewStudioWeb.ShopLive do
  use LiveViewStudioWeb, :live_view

  alias LiveViewStudio.Products

  def mount(_params, _session, socket) do
    {:ok,
     assign(socket,
       products: Products.list_products(),
       cart: %{},
       show_cart: false
     )}
  end

  def handle_event("add-product", %{"product" => product}, socket) do
    cart = Map.update(socket.assigns.cart, product, 1, &(&1 + 1))
    {:noreply, assign(socket, :cart, cart)}
  end

  def toggle_cart(js \\ %JS{}) do
    js
    |> JS.toggle(
      to: "#cart",
      in: {
        "ease-in-out duration-300",
        "translate-x-full",
        "translate-x-0"
      },
      out: {
        "ease-in-out duration-300",
        "translate-x-0",
        "translate-x-full"
      },
      time: 300
    )
    |> JS.toggle(
      to: "#backdrop",
      in: "fade-in",
      out: "fade-out"
    )
  end

  def add_product(product) do
    JS.push("add-product", value: %{product: product.image})
    |> JS.transition("shake", to: "#cart-button", time: 500)
  end
end
